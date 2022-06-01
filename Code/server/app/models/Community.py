from datetime import datetime
from typing import Optional
from .User import User
from odmantic import Model, Reference, Field

class Question(Model):
    content: str = Field()
    pet_type: Optional[str]
    owner: User = Reference()
    answers: int = 0
    created_at: datetime = Field(default_factory=datetime.utcnow)
    

    class Config:
        collection = 'questions'
        parse_doc_with_default_factories = True

class Answer(Model):
    content: str = Field()
    owner: User = Reference()
    question: Question = Reference()
    created_at: datetime = Field(default_factory=datetime.utcnow)
    

    class Config:
        collection = 'answers'
        parse_doc_with_default_factories = True