from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
import logging

# Configuración básica de logging
logger = logging.getLogger(__name__)

async def send_fcm_notification(db: AsyncSession, usuario_id: int, titulo: str, mensaje: str, data: dict = None):
    """
    Simula el envío de una notificación push via FCM a todos los dispositivos de un usuario
    y registra la notificación en el historial.
    """
    # 1. Obtener tokens del usuario
    query_tokens = text("SELECT token_fcm FROM dispositivos_fcm WHERE usuario_id = :user_id")
    result = await db.execute(query_tokens, {"user_id": usuario_id})
    tokens = [row["token_fcm"] for row in result.mappings().all()]

    if not tokens:
        logger.warning(f"No se encontraron tokens FCM para el usuario {usuario_id}")
    else:
        # Aquí iría la integración real con firebase-admin
        # Example:
        # message = messaging.MulticastMessage(
        #     notification=messaging.Notification(title=titulo, body=mensaje),
        #     data=data,
        #     tokens=tokens,
        # )
        # response = messaging.send_multicast(message)
        logger.info(f"Enviando notificación a {len(tokens)} dispositivos del usuario {usuario_id}: {titulo}")

    # 2. Registrar en historial (SQL Puro)
    insert_historial = text("""
        INSERT INTO notificaciones_historial (usuario_id, titulo, mensaje, tipo, leida)
        VALUES (:user_id, :titulo, :mensaje, :tipo, :leida)
    """)
    await db.execute(insert_historial, {
        "user_id": usuario_id,
        "titulo": titulo,
        "mensaje": mensaje,
        "tipo": "push",
        "leida": False
    })
    
    await db.commit()
    return True

async def send_notification_to_channel(db: AsyncSession, slug_canal: str, titulo: str, mensaje: str, data: dict = None):
    """
    Envía una notificación a todos los usuarios suscritos a un canal específico.
    """
    # 1. Obtener ID del canal
    result_canal = await db.execute(text("SELECT id FROM canales_notificacion WHERE slug = :slug"), {"slug": slug_canal})
    canal_row = result_canal.mappings().first()
    if not canal_row:
        logger.error(f"Canal no encontrado: {slug_canal}")
        return False
    
    canal_id = canal_row["id"]

    # 2. Obtener usuarios suscritos y sus tokens
    query_suscritos = text("""
        SELECT d.usuario_id, d.token_fcm 
        FROM dispositivos_fcm d
        JOIN usuario_suscripciones s ON d.usuario_id = s.usuario_id
        WHERE s.canal_id = :canal_id AND s.activo = 1
    """)
    result = await db.execute(query_suscritos, {"canal_id": canal_id})
    rows = result.mappings().all()

    if not rows:
        logger.info(f"No hay suscriptores activos para el canal {slug_canal}")
        return True

    # Agrupar tokens y usuarios para envío e historial
    tokens = [row["token_fcm"] for row in rows]
    usuarios_ids = list(set([row["usuario_id"] for row in rows]))

    # Simulación de envío masivo
    logger.info(f"Enviando notificación masiva al canal {slug_canal} ({len(tokens)} tokens)")

    # 3. Registrar en historial para cada usuario
    insert_historial = text("""
        INSERT INTO notificaciones_historial (usuario_id, titulo, mensaje, tipo, leida)
        VALUES (:user_id, :titulo, :mensaje, :tipo, :leida)
    """)
    
    for u_id in usuarios_ids:
        await db.execute(insert_historial, {
            "user_id": u_id,
            "titulo": titulo,
            "mensaje": mensaje,
            "tipo": "canal",
            "leida": False
        })
    
    await db.commit()
    return True
