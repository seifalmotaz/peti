import uuid
from datetime import datetime
from typing import Optional
from pydantic import EmailStr
from odmantic import Model, Field, Reference
from app.models.Location import Location


def getToken():
    return uuid.uuid4().hex


class User(Model):
    avatar: Optional[str]
    first_name: str = Field(max_length=50)
    last_name: str = Field(max_length=50)
    email: EmailStr = Field(unique=True)
    password: Optional[str]
    phone: Optional[str]
    location: Location = Reference()
    access_token: Optional[str] = Field(default_factory=getToken)
    created_at: datetime = Field(default_factory=datetime.utcnow)
    last_login: datetime = Field(default_factory=datetime.utcnow)
    oauth: Optional[dict]

    class Config:
        collection = 'users'
        parse_doc_with_default_factories = True
