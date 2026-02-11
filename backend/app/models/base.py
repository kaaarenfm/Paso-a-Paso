from sqlalchemy.dialects.mysql import BIGINT
from sqlalchemy import Column, TIMESTAMP
from app.core.database import Base

class SoftDeleteMixin:
    deleted_at = Column(TIMESTAMP, nullable=True)

# Define common BigInteger type for MySQL to be unsigned if needed
def MySQLBigInteger():
    return BIGINT(unsigned=True)
