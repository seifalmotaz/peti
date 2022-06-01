from app.models import Pet, User
from app.config.decorators import as_form
from datetime import datetime
from typing import Optional
from pydantic import BaseModel

@as_form
class PetCreate(BaseModel):
    name: str
    gender: str
    birthday: datetime
    type: str
    breed: Optional[str]
    want_marraige: bool = True


class PetUpdate(BaseModel):
    name: Optional[str]
    gender: Optional[str]
    birthday: Optional[datetime]
    type: Optional[str]
    breed: Optional[str]
    want_marraige: Optional[bool]