from pydantic import BaseModel
from typing import Optional, List

class FCMTokenCreate(BaseModel):
    token_fcm: str
    plataforma: str
    idioma: str = "es"

class SuscripcionUpdate(BaseModel):
    slug: str
    activo: bool

class NotificacionSend(BaseModel):
    usuario_id: int
    titulo: str
    mensaje: str
    data: Optional[dict] = None

class NotificacionMasiva(BaseModel):
    slug_canal: str
    titulo: str
    mensaje: str
    data: Optional[dict] = None
