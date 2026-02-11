from app.schemas.auth import UserRegister, Token, TokenData
from app.schemas.rutina import (
    HabitoBase, HabitoCreate, Habito, RutinaBase, RutinaCreate, Rutina,
    CategoriaRutina, CategoriaRutinaCreate, HabitoCategoria, HabitoCategoriaCreate,
    RutinaRating, RutinaRatingCreate,
    HistorialRutina, HistorialRutinaCreate
)
from app.schemas.seguimiento import SeguimientoCreate
from app.schemas.notificacion import FCMTokenCreate, SuscripcionUpdate, NotificacionSend, NotificacionMasiva
from app.schemas.usuario import Seguidor, SeguidorCreate, UsuarioSimple, SuscripcionDetalle, PlanUpdate
