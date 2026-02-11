from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    PROJECT_NAME: str = "Step by Step"
    SECRET_KEY: str = "YOUR_SECRET_KEY_HERE" # En producción usar una variable de entorno
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    DATABASE_URL: str = "mysql+aiomysql://root:Lisa7870@localhost/rutinas_test"

    class Config:
        env_file = ".env"

settings = Settings()
