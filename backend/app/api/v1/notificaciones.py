from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from app.core.database import get_db
from app.api.v1.auth import get_current_user
from app.models import Usuario, DispositivoFCM, UsuarioSuscripcion, CanalNotificacion
from app.schemas import FCMTokenCreate, SuscripcionUpdate, NotificacionSend, NotificacionMasiva
from app.services.notificaciones_service import send_fcm_notification, send_notification_to_channel

router = APIRouter(tags=["notificaciones"])

@router.post("/dispositivos-fcm", summary="Registrar dispositivo FCM", description="Registra o actualiza el token FCM vinculado al usuario autenticado para recibir notificaciones push.")
async def register_fcm_token(token_in: FCMTokenCreate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    result = await db.execute(text("SELECT * FROM dispositivos_fcm WHERE token_fcm = :token"), {"token": token_in.token_fcm})
    row = result.mappings().first()
    device = DispositivoFCM(**row) if row else None
    
    if device:
        update_query = text("""
            UPDATE dispositivos_fcm 
            SET usuario_id = :user_id, plataforma = :plataforma, idioma = :idioma 
            WHERE token_fcm = :token
        """)
        await db.execute(update_query, {
            "user_id": current_user.id,
            "plataforma": token_in.plataforma,
            "idioma": token_in.idioma,
            "token": token_in.token_fcm
        })
    else:
        insert_query = text("""
            INSERT INTO dispositivos_fcm (usuario_id, token_fcm, plataforma, idioma)
            VALUES (:user_id, :token, :plataforma, :idioma)
        """)
        await db.execute(insert_query, {
            "user_id": current_user.id,
            "token": token_in.token_fcm,
            "plataforma": token_in.plataforma,
            "idioma": token_in.idioma
        })
    
    await db.commit()
    return {"status": "success"}

@router.patch("/suscripciones-canales", summary="Actualizar suscripciones a canales", description="Permite al usuario activar o desactivar la recepción de notificaciones por canales específicos (Topics) mediante su slug.")
async def update_subscriptions(sub_in: SuscripcionUpdate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    result_canal = await db.execute(text("SELECT * FROM canales_notificacion WHERE slug = :slug"), {"slug": sub_in.slug})
    canal_row = result_canal.mappings().first()
    if not canal_row:
        raise HTTPException(status_code=404, detail="Canal no encontrado")
    
    canal = CanalNotificacion(**canal_row)
    
    result_sub = await db.execute(text("""
        SELECT * FROM usuario_suscripciones 
        WHERE usuario_id = :user_id AND canal_id = :canal_id
    """), {"user_id": current_user.id, "canal_id": canal.id})
    sub_row = result_sub.mappings().first()
    subscription = UsuarioSuscripcion(**sub_row) if sub_row else None
    
    if subscription:
        # SQL UPDATE para UsuarioSuscripcion
        await db.execute(text("""
            UPDATE usuario_suscripciones 
            SET activo = :activo 
            WHERE usuario_id = :user_id AND canal_id = :canal_id
        """), {
            "activo": sub_in.activo,
            "user_id": current_user.id,
            "canal_id": canal.id
        })
    else:
        # SQL INSERT para UsuarioSuscripcion
        await db.execute(text("""
            INSERT INTO usuario_suscripciones (usuario_id, canal_id, activo)
            VALUES (:user_id, :canal_id, :activo)
        """), {
            "user_id": current_user.id,
            "canal_id": canal.id,
            "activo": sub_in.activo
        })
        
    await db.commit()
    return {"status": "success"}

# Endpoint solicitado específicamente en el resumen
@router.post("/fcm/token", summary="Alias para registro de FCM", description="Ruta alternativa para registrar el token FCM, siguiendo convenciones de equipo.")
async def save_fcm_token_alias(token_in: FCMTokenCreate, current_user: Usuario = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    return await register_fcm_token(token_in, current_user, db)

@router.post("/fcm/enviar", summary="Enviar notificación push individual", description="Envía una notificación push a un usuario específico y la registra en su historial.")
async def send_push_notification(notif: NotificacionSend, db: AsyncSession = Depends(get_db)):
    success = await send_fcm_notification(db, notif.usuario_id, notif.titulo, notif.mensaje, notif.data)
    if not success:
        raise HTTPException(status_code=500, detail="Error enviando notificación")
    return {"status": "success"}

@router.post("/fcm/enviar-canal", summary="Enviar notificación masiva por canal", description="Envía una notificación push a todos los usuarios suscritos a un canal (Topic) específico.")
async def send_channel_notification(notif: NotificacionMasiva, db: AsyncSession = Depends(get_db)):
    success = await send_notification_to_channel(db, notif.slug_canal, notif.titulo, notif.mensaje, notif.data)
    if not success:
        raise HTTPException(status_code=404, detail="Canal no encontrado o error en el envío")
    return {"status": "success"}
