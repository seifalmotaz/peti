from enum import Enum
from datetime import datetime
from typing import Optional
from .User import User
from odmantic import Model, Reference, Field


class Gender(str, Enum):
    MALE = "Male"
    FEMALE = "Female"


class Pet(Model):
    avatar: Optional[str]
    name: str = Field(max_length=50)
    birthday: datetime
    gender: Gender
    type: str
    breed: Optional[str]
    want_marraige: bool = True
    owner: User = Reference()
    likes: int = 0
    followers: int = 0
    created_at: datetime = Field(default_factory=datetime.utcnow)
    

    class Config:
        collection = 'pets'
        parse_doc_with_default_factories = True

class Follower(Model):
    following: Pet = Reference()
    follower: User = Reference()
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Config:
        collection = 'followers'
        parse_doc_with_default_factories = True
