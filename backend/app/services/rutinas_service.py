from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from app.models import Rutina, Habito, Usuario
from typing import List

async def get_rutina(db: AsyncSession, rutina_id: int):
    result = await db.execute(text("SELECT * FROM rutinas WHERE id = :id AND deleted_at IS NULL"), {"id": rutina_id})
    row = result.mappings().first()
    return Rutina(**row) if row else None

async def clone_rutina_for_user(db: AsyncSession, rutina_id: int, user_id: int):
    # Obtener rutina original
    original_rutina = await get_rutina(db, rutina_id)
    if not original_rutina:
        return None
    
    # SQL INSERT para nueva rutina clonada
    insert_rutina_query = text("""
        INSERT INTO rutinas (usuario_id, nombre, momento_dia, es_publica, creada_por_ia, estado)
        VALUES (:usuario_id, :nombre, :momento_dia, :es_publica, :creada_por_ia, :estado)
    """)
    result_rutina = await db.execute(insert_rutina_query, {
        "usuario_id": user_id,
        "nombre": f"Copia de {original_rutina.nombre}",
        "momento_dia": original_rutina.momento_dia,
        "es_publica": False,
        "creada_por_ia": original_rutina.creada_por_ia,
        "estado": original_rutina.estado
    })
    new_rutina_id = result_rutina.lastrowid
    
    # Clonar habitos con SQL INSERT
    result_h = await db.execute(text("SELECT * FROM habitos WHERE rutina_id = :r_id AND deleted_at IS NULL"), {"r_id": rutina_id})
    h_rows = result_h.mappings().all()
    original_habitos = [Habito(**row) for row in h_rows]
    
    insert_habito_query = text("""
        INSERT INTO habitos (rutina_id, categoria_id, nombre, descripcion, tiempo_programado, tiempo_duracion_min, orden, estado)
        VALUES (:rutina_id, :categoria_id, :nombre, :descripcion, :tiempo_programado, :tiempo_duracion_min, :orden, :estado)
    """)
    
    for h in original_habitos:
        await db.execute(insert_habito_query, {
            "rutina_id": new_rutina_id,
            "categoria_id": h.categoria_id,
            "nombre": h.nombre,
            "descripcion": h.descripcion,
            "tiempo_programado": h.tiempo_programado,
            "tiempo_duracion_min": h.tiempo_duracion_min,
            "orden": h.orden,
            "estado": h.estado
        })
    
    await db.commit()
    
    # Obtener la nueva rutina con sus hábitos para retornar
    result_final = await db.execute(text("SELECT * FROM rutinas WHERE id = :id"), {"id": new_rutina_id})
    rutina_row = result_final.mappings().first()
    new_rutina = Rutina(**rutina_row)
    
    h_result = await db.execute(text("SELECT * FROM habitos WHERE rutina_id = :r_id AND deleted_at IS NULL"), {"r_id": new_rutina_id})
    h_rows = h_result.mappings().all()
    new_rutina.habitos = [Habito(**row) for row in h_rows]
    
    return new_rutina
