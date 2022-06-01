from datetime import datetime
from typing import Optional
from . import Pet
from odmantic import Model, Reference, Field

class Request(Model):
    sender: Pet = Reference()
    receiver: Pet = Reference()
    is_accepted: Optional[bool] = None
    is_completed: bool = False
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Config:
        collection = 'requests'
        parse_doc_with_default_factories = True