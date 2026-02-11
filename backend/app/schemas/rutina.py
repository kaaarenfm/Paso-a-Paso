from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import time, datetime

class CategoriaRutinaBase(BaseModel):
    nombre: str
    descripcion: Optional[str] = None
    padre_id: Optional[int] = None

class CategoriaRutinaCreate(CategoriaRutinaBase):
    pass

class CategoriaRutina(CategoriaRutinaBase):
    id: int
    subcategorias: List['CategoriaRutina'] = []
    class Config:
        from_attributes = True

class HabitoCategoriaBase(BaseModel):
    nombre: str
    descripcion: Optional[str] = None

class HabitoCategoriaCreate(HabitoCategoriaBase):
    pass

class HabitoCategoria(HabitoCategoriaBase):
    id: int
    estado: bool = True
    class Config:
        from_attributes = True

class RutinaRatingBase(BaseModel):
    puntuacion: int = Field(..., ge=1, le=5)
    comentario: Optional[str] = None

class RutinaRatingCreate(RutinaRatingBase):
    pass

class RutinaRating(RutinaRatingBase):
    id: int
    rutina_id: int
    usuario_id: int
    fecha: datetime
    class Config:
        from_attributes = True

class LikeRutina(BaseModel):
    rutina_id: int
    usuario_id: int
    fecha: datetime
    class Config:
        from_attributes = True

class HistorialRutinaCreate(BaseModel):
    rutina_id: int
    duracion_total_min: Optional[int] = None

class HistorialRutina(BaseModel):
    id: int
    usuario_id: int
    rutina_id: int
    fecha_completada: datetime
    duracion_total_min: Optional[int] = None
    class Config:
        from_attributes = True

class HabitoBase(BaseModel):
    nombre: str
    descripcion: Optional[str] = None
    categoria_id: Optional[int] = None
    tiempo_programado: Optional[time] = None
    tiempo_duracion_min: Optional[int] = None
    orden: int = 0

class HabitoCreate(HabitoBase):
    pass

class Habito(HabitoBase):
    id: int
    rutina_id: int
    class Config:
        from_attributes = True

class RutinaBase(BaseModel):
    nombre: str
    momento_dia: str = "mañana"
    es_publica: bool = False
    categoria_id: Optional[int] = None

class RutinaCreate(RutinaBase):
    habitos: List[HabitoCreate] = Field(default=[], example=[
        {
            "nombre": "Beber agua",
            "descripcion": "500ml al despertar",
            "categoria_id": 1,
            "tiempo_programado": "07:00:00",
            "tiempo_duracion_min": 5,
            "orden": 1
        }
    ])

class Rutina(RutinaBase):
    id: int
    usuario_id: int
    habitos: List[Habito] = []
    rating_promedio: Optional[float] = 0.0
    total_likes: Optional[int] = 0
    class Config:
        from_attributes = True
