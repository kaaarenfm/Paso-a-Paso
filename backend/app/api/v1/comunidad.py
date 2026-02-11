from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from sqlalchemy.orm import selectinload
from typing import List
from app.core.database import get_db
from app.models import Rutina, Habito
from app.schemas import Rutina as RutinaSchema

router = APIRouter(prefix="/comunidad", tags=["comunidad"])

@router.get("/explorar", response_model=List[RutinaSchema], summary="Explorar rutinas públicas", description="Acceso público. Retorna todas las rutinas marcadas como `es_publica = 1`. Ideal para la vitrina de la aplicación.")
async def explorar_rutinas_publicas(db: AsyncSession = Depends(get_db)):
    query = text("""
        SELECT * FROM rutinas 
        WHERE es_publica = 1 AND deleted_at IS NULL
    """)
    result = await db.execute(query)
    rows = result.mappings().all()
    rutinas = [Rutina(**row) for row in rows]
    
    for r in rutinas:
        h_query = text("SELECT * FROM habitos WHERE rutina_id = :r_id AND deleted_at IS NULL")
        h_result = await db.execute(h_query, {"r_id": r.id})
        h_rows = h_result.mappings().all()
        r.habitos = [Habito(**row) for row in h_rows]
        
    return rutinas
