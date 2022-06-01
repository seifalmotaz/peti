from app.models.Location import Specifics as Specifics
from typing import Optional
from pydantic import BaseModel
from pydantic.networks import EmailStr


class LocationUpdate(BaseModel):
    iso: Optional[str]
    country: Optional[str]
    region:  Optional[str]
    city: Optional[str]
    specifics: Optional[Specifics]


class UserUpdate(BaseModel):
    first_name: Optional[str]
    last_name: Optional[str]
    email: Optional[EmailStr]
    phone: Optional[str]
    location: Optional[LocationUpdate]
