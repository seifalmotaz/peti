from datetime import datetime
from typing import Optional
from odmantic import Model, Field, EmbeddedModel, ObjectId

class Specifics(EmbeddedModel):
    type: str = "Point"
    coordinates: list  # [longitude, latitude]


class Location(Model):
    home: bool = True
    iso: Optional[str]
    country: Optional[str]
    city: Optional[str]
    region:  Optional[str]
    specifics: Optional[Specifics]
    owner: Optional[ObjectId]
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Config:
        collection = 'locations'
        parse_doc_with_default_factories = True