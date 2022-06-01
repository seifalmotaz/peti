from app.config.decorators import as_form
from app.models import ObjectId
from typing import Optional
from pydantic import BaseModel, Field

@as_form
class PostCreate(BaseModel):
    creator_id: ObjectId
    caption: Optional[str] = Field(max_length=300)
    color: str