from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class SeguidorBase(BaseModel):
    seguido_id: int

class SeguidorCreate(SeguidorBase):
    pass

class Seguidor(SeguidorBase):
    id: int
    seguidor_id: int
    fecha_seguimiento: datetime
    class Config:
        from_attributes = True

class UsuarioSimple(BaseModel):
    id: int
    nombre: str
    foto_perfil: Optional[str] = None
    class Config:
        from_attributes = True

class SuscripcionDetalle(BaseModel):
    plan_id: Optional[int]
    plan_nombre: str
    fecha_fin_trial: Optional[datetime]
    dias_restantes: int
    es_premium: bool

class PlanUpdate(BaseModel):
    plan_id: int
