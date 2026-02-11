from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from typing import List
from app.core.database import get_db
from app.api.v1.auth import get_current_user
from app.models import Usuario, Seguidor, Plan
from app.schemas import Seguidor as SeguidorSchema, SeguidorCreate, UsuarioSimple, SuscripcionDetalle, PlanUpdate
from datetime import datetime, timedelta

router = APIRouter(prefix="/usuarios", tags=["usuarios"])

@router.post("/seguir/{seguido_id}", summary="Seguir a un usuario")
async def follow_user(seguido_id: int, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    if seguido_id == current_user.id:
        raise HTTPException(status_code=400, detail="No puedes seguirte a ti mismo")
    
    check_user = await db.execute(text("SELECT id FROM usuarios WHERE id = :id"), {"id": seguido_id})
    if not check_user.first():
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    check_query = text("SELECT id FROM seguidores WHERE seguidor_id = :s_id AND seguido_id = :f_id")
    result = await db.execute(check_query, {"s_id": current_user.id, "f_id": seguido_id})
    
    if result.first():
        # Toggle: Dejar de seguir
        await db.execute(text("DELETE FROM seguidores WHERE seguidor_id = :s_id AND seguido_id = :f_id"), {"s_id": current_user.id, "f_id": seguido_id})
        await db.commit()
        return {"status": "unfollowed"}
    
    await db.execute(text("INSERT INTO seguidores (seguidor_id, seguido_id) VALUES (:s_id, :f_id)"), {"s_id": current_user.id, "f_id": seguido_id})
    await db.commit()
    return {"status": "followed"}

@router.get("/seguidores", response_model=List[UsuarioSimple], summary="Listar mis seguidores")
async def get_my_followers(current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    query = text("""
        SELECT u.id, u.nombre, u.foto_perfil FROM usuarios u
        JOIN seguidores s ON u.id = s.seguidor_id
        WHERE s.seguido_id = :u_id
    """)
    result = await db.execute(query, {"u_id": current_user.id})
    return result.mappings().all()

@router.get("/siguiendo", response_model=List[UsuarioSimple], summary="Listar personas que sigo")
async def get_following(current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    query = text("""
        SELECT u.id, u.nombre, u.foto_perfil FROM usuarios u
        JOIN seguidores s ON u.id = s.seguido_id
        WHERE s.seguidor_id = :u_id
    """)
    result = await db.execute(query, {"u_id": current_user.id})
    return result.mappings().all()

@router.get("/suscripcion", response_model=SuscripcionDetalle, summary="Detalles de mi suscripción")
async def get_my_subscription(current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    query = text("""
        SELECT p.id, p.nombre, p.duracion_trial_dias
        FROM planes p
        WHERE p.id = :plan_id
    """)
    result = await db.execute(query, {"plan_id": current_user.plan_id})
    plan = result.mappings().first()
    
    plan_nombre = plan["nombre"] if plan else "Sin Plan"
    dias_restantes = 0
    if current_user.fecha_fin_trial:
        delta = current_user.fecha_fin_trial - datetime.now()
        dias_restantes = max(0, delta.days)
    
    return {
        "plan_id": current_user.plan_id,
        "plan_nombre": plan_nombre,
        "fecha_fin_trial": current_user.fecha_fin_trial,
        "dias_restantes": dias_restantes,
        "es_premium": plan_nombre not in ["Gratuito", "Free", "Sin Plan"]
    }

@router.post("/suscripcion/iniciar", summary="Iniciar suscripción (Asignar plan)")
async def start_subscription(plan_in: PlanUpdate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    # Verificar que el plan existe
    plan_query = text("SELECT * FROM planes WHERE id = :p_id")
    plan_res = await db.execute(plan_query, {"p_id": plan_in.plan_id})
    plan = plan_res.mappings().first()
    if not plan:
        raise HTTPException(status_code=404, detail="Plan no encontrado")
    
    fecha_fin_trial = None
    if plan["nombre"] in ["Gratuito", "Free"]:
        fecha_fin_trial = datetime.now() + timedelta(days=plan["duracion_trial_dias"])
    
    update_query = text("""
        UPDATE usuarios 
        SET plan_id = :p_id, fecha_fin_trial = :f_trial, estado = 'activo'
        WHERE id = :u_id
    """)
    await db.execute(update_query, {
        "p_id": plan_in.plan_id,
        "f_trial": fecha_fin_trial,
        "u_id": current_user.id
    })
    await db.commit()
    
    return {"status": "success", "message": f"Suscripción al plan {plan['nombre']} iniciada"}
