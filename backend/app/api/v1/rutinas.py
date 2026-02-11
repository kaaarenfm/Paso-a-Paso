from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from sqlalchemy.orm import selectinload
from typing import List
from app.core.database import get_db
from app.api.v1.auth import get_current_user
from app.models import (
    Rutina, Habito, Usuario, SeguimientoHabito, 
    CategoriaRutina, RutinaRating, HistorialRutina, LikeRutina
)
from app.schemas import (
    RutinaCreate, Rutina as RutinaSchema, SeguimientoCreate,
    CategoriaRutina as CategoriaSchema, HabitoCategoria as HabitoCategoriaSchema,
    RutinaRatingCreate, HistorialRutinaCreate,
    HistorialRutina as HistorialSchema, UsuarioSimple
)
from app.services.rutinas_service import clone_rutina_for_user
from app.services.gamificacion_service import update_mascota_status, add_exp_to_mascota
from app.services.notificaciones_service import send_fcm_notification

router = APIRouter(prefix="/rutinas", tags=["rutinas"])

@router.get("/me", response_model=List[RutinaSchema], summary="Obtener mis rutinas", description="Retorna todas las rutinas del usuario autenticado, incluyendo sus hábitos asociados.")
async def get_my_routines(current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):

    
    query = text("""
        SELECT * FROM rutinas 
        WHERE usuario_id = :user_id AND deleted_at IS NULL
    """)
    result = await db.execute(query, {"user_id": current_user.id})
    rows = result.mappings().all()
    rutinas = [Rutina(**row) for row in rows]
    
    for r in rutinas:
        h_query = text("SELECT * FROM habitos WHERE rutina_id = :r_id AND deleted_at IS NULL")
        h_result = await db.execute(h_query, {"r_id": r.id})
        h_rows = h_result.mappings().all()
        r.habitos = [Habito(**row) for row in h_rows]
        
    return rutinas

@router.post("/", response_model=RutinaSchema, summary="Crear rutina", description="Crea una nueva rutina con sus hábitos asociados para el usuario autenticado. Sujeto a restricciones de Trial.")
async def create_routine(rutina_in: RutinaCreate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    # Nota: El middleware de Trial validará esto antes de entrar aquí
    
    # SQL INSERT para Rutina
    insert_rutina_query = text("""
        INSERT INTO rutinas (usuario_id, nombre, momento_dia, es_publica)
        VALUES (:usuario_id, :nombre, :momento_dia, :es_publica)
    """)
    result_rutina = await db.execute(insert_rutina_query, {
        "usuario_id": current_user.id,
        "nombre": rutina_in.nombre,
        "momento_dia": rutina_in.momento_dia,
        "es_publica": rutina_in.es_publica
    })
    rutina_id = result_rutina.lastrowid
    
    # SQL INSERT para Habitos
    insert_habito_query = text("""
        INSERT INTO habitos (rutina_id, nombre, descripcion, categoria_id, tiempo_programado, tiempo_duracion_min, orden)
        VALUES (:rutina_id, :nombre, :descripcion, :categoria_id, :tiempo_programado, :tiempo_duracion_min, :orden)
    """)
    
    for h in rutina_in.habitos:
        await db.execute(insert_habito_query, {
            "rutina_id": rutina_id,
            "nombre": h.nombre,
            "descripcion": h.descripcion,
            "categoria_id": h.categoria_id,
            "tiempo_programado": h.tiempo_programado,
            "tiempo_duracion_min": h.tiempo_duracion_min,
            "orden": h.orden
        })
    
    await db.commit()
    
    # Obtener la rutina creada con sus hábitos para la respuesta
    result_final = await db.execute(text("SELECT * FROM rutinas WHERE id = :id"), {"id": rutina_id})
    rutina_row = result_final.mappings().first()
    new_rutina = Rutina(**rutina_row)
    
    h_result = await db.execute(text("SELECT * FROM habitos WHERE rutina_id = :r_id AND deleted_at IS NULL"), {"r_id": rutina_id})
    h_rows = h_result.mappings().all()
    new_rutina.habitos = [Habito(**row) for row in h_rows]
    
    return new_rutina

@router.post("/copiar/{rutina_id}", response_model=RutinaSchema, summary="Copiar rutina pública", description="Clona una rutina pública y todos sus hábitos para el usuario autenticado. El clon se marca como privado por defecto.")
async def copy_routine(rutina_id: int, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    cloned = await clone_rutina_for_user(db, rutina_id, current_user.id)
    if not cloned:
        raise HTTPException(status_code=404, detail="Rutina no encontrada")
    return cloned

@router.post("/habitos/check", summary="Marcar cumplimiento de hábito", description="Registra el cumplimiento de un hábito para una fecha específica. Otorga EXP a la mascota virtual si el estado es completado (1).")
async def check_habit(seguimiento_in: SeguimientoCreate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    # Verificar que el hábito pertenezca al usuario
    query = text("""
        SELECT h.* FROM habitos h
        JOIN rutinas r ON h.rutina_id = r.id
        WHERE h.id = :habito_id AND r.usuario_id = :user_id
    """)
    habit_result = await db.execute(query, {"habito_id": seguimiento_in.habito_id, "user_id": current_user.id})
    habit_row = habit_result.mappings().first()
    if not habit_row:
        raise HTTPException(status_code=404, detail="Hábito no encontrado")
    
    habit = Habito(**habit_row)
        
    # SQL INSERT para SeguimientoHabito
    insert_seguimiento_query = text("""
        INSERT INTO seguimiento_habitos (habito_id, fecha, estado, nota, estado_animo)
        VALUES (:habito_id, :fecha, :estado, :nota, :estado_animo)
    """)
    await db.execute(insert_seguimiento_query, {
        "habito_id": seguimiento_in.habito_id,
        "fecha": seguimiento_in.fecha,
        "estado": seguimiento_in.estado,
        "nota": seguimiento_in.nota,
        "estado_animo": seguimiento_in.estado_animo
    })
    
    if seguimiento_in.estado:
        await add_exp_to_mascota(db, current_user.id, 10) # 10 EXP por check
        await update_mascota_status(db, current_user.id)
    
    await db.commit()
    return {"status": "success"}

# --- Nuevos Endpoints ---

@router.get("/categorias", response_model=List[CategoriaSchema], summary="Listar categorías de rutinas")
async def get_categories(db: AsyncSession = Depends(get_db)):
    result = await db.execute(text("SELECT * FROM categorias_rutina WHERE estado = 1 AND padre_id IS NULL"))
    rows = result.mappings().all()
    categories = []
    for row in rows:
        cat = CategoriaSchema.model_validate(row)
        # Buscar subcategorías
        sub_result = await db.execute(text("SELECT * FROM categorias_rutina WHERE padre_id = :p_id AND estado = 1"), {"p_id": cat.id})
        cat.subcategorias = [CategoriaSchema.model_validate(s_row) for s_row in sub_result.mappings().all()]
        categories.append(cat)
    return categories

@router.get("/habitos/categorias", response_model=List[HabitoCategoriaSchema], summary="Listar categorías de hábitos")
async def get_habit_categories(db: AsyncSession = Depends(get_db)):
    result = await db.execute(text("SELECT * FROM habitos_categoria WHERE estado = 1"))
    return result.mappings().all()

@router.post("/like/{rutina_id}", summary="Dar like a una rutina")
async def like_routine(rutina_id: int, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    # Verificar si ya existe el like
    check_query = text("SELECT id FROM likes_rutina WHERE rutina_id = :r_id AND usuario_id = :u_id")
    result = await db.execute(check_query, {"r_id": rutina_id, "u_id": current_user.id})
    if result.first():
        # Si existe, lo quitamos (Toggle)
        await db.execute(text("DELETE FROM likes_rutina WHERE rutina_id = :r_id AND usuario_id = :u_id"), {"r_id": rutina_id, "u_id": current_user.id})
        await db.commit()
        return {"status": "unliked"}
    
    await db.execute(text("INSERT INTO likes_rutina (rutina_id, usuario_id) VALUES (:r_id, :u_id)"), {"r_id": rutina_id, "u_id": current_user.id})
    await db.commit()
    return {"status": "liked"}

@router.post("/rate/{rutina_id}", summary="Calificar una rutina")
async def rate_routine(rutina_id: int, rating_in: RutinaRatingCreate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    # Upsert rating
    check_query = text("SELECT id FROM rutina_ratings WHERE rutina_id = :r_id AND usuario_id = :u_id")
    result = await db.execute(check_query, {"r_id": rutina_id, "u_id": current_user.id})
    
    if result.first():
        update_query = text("""
            UPDATE rutina_ratings SET puntuacion = :p, comentario = :c, fecha = CURRENT_TIMESTAMP
            WHERE rutina_id = :r_id AND usuario_id = :u_id
        """)
        await db.execute(update_query, {"p": rating_in.puntuacion, "c": rating_in.comentario, "r_id": rutina_id, "u_id": current_user.id})
    else:
        insert_query = text("""
            INSERT INTO rutina_ratings (rutina_id, usuario_id, puntuacion, comentario)
            VALUES (:r_id, :u_id, :p, :c)
        """)
        await db.execute(insert_query, {"r_id": rutina_id, "u_id": current_user.id, "p": rating_in.puntuacion, "c": rating_in.comentario})
    
    await db.commit()
    return {"status": "success", "message": "Calificación registrada"}

@router.post("/completar", summary="Registrar rutina completada (Historial)")
async def complete_routine(historial_in: HistorialRutinaCreate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    insert_query = text("""
        INSERT INTO historial_rutinas (usuario_id, rutina_id, duracion_total_min)
        VALUES (:u_id, :r_id, :d)
    """)
    await db.execute(insert_query, {"u_id": current_user.id, "r_id": historial_in.rutina_id, "d": historial_in.duracion_total_min})
    
    # Podríamos dar más EXP por completar rutina completa
    await add_exp_to_mascota(db, current_user.id, 50)
    await update_mascota_status(db, current_user.id)
    
    await db.commit()
    return {"status": "success", "message": "Historial de rutina registrado"}

@router.get("/historial", response_model=List[HistorialSchema], summary="Obtener mi historial de rutinas")
async def get_my_history(current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    query = text("SELECT * FROM historial_rutinas WHERE usuario_id = :u_id ORDER BY fecha_completada DESC")
    result = await db.execute(query, {"u_id": current_user.id})
    return result.mappings().all()

@router.get("/likes/{rutina_id}", response_model=List[UsuarioSimple], summary="Usuarios que dieron like a esta rutina")
async def get_routine_likes(rutina_id: int, db: AsyncSession = Depends(get_db)):
    query = text("""
        SELECT u.id, u.nombre, u.foto_perfil FROM usuarios u
        JOIN likes_rutina l ON u.id = l.usuario_id
        WHERE l.rutina_id = :r_id
    """)
    result = await db.execute(query, {"r_id": rutina_id})
    return result.mappings().all()

@router.get("/perfil/{usuario_id}", summary="Obtener perfil público de usuario")
async def get_user_profile(usuario_id: int, db: AsyncSession = Depends(get_db)):
    query = text("""
        SELECT u.id, u.nombre, u.apellido_paterno, u.foto_perfil, 
               (SELECT COUNT(*) FROM seguidores WHERE seguido_id = u.id) as seguidores_count,
               (SELECT COUNT(*) FROM seguidores WHERE seguidor_id = u.id) as siguiendo_count
        FROM usuarios u
        WHERE u.id = :u_id
    """)
    result = await db.execute(query, {"u_id": usuario_id})
    user = result.mappings().first()
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    
    # Obtener rutinas públicas
    r_query = text("SELECT id, nombre, momento_dia FROM rutinas WHERE usuario_id = :u_id AND es_publica = 1 AND deleted_at IS NULL")
    r_result = await db.execute(r_query, {"u_id": usuario_id})
    
    return {
        "usuario": user,
        "rutinas_publicas": r_result.mappings().all()
    }


