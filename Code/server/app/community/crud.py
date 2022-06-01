from typing import List, Optional
from fastapi import APIRouter, Depends
from pydantic.main import BaseModel
from app.config.depends import get_current_user
from app.models import User, engine, Question, Answer, ObjectId
from .funcs import is_question_owner, is_answer_owner, is_question_exist

router = APIRouter(prefix="")


class QuestionCreate(BaseModel):
    content: str
    pet_type: Optional[str]


@router.post('/questions/', response_model=List[Question], response_model_exclude={
    "owner": {
        "password",
        "phone",
        "location",
        "access_token",
        "created_at", "last_login", "oauth",
    }
})
async def create_question(page: int = 0, current_user: User = Depends(get_current_user)):
    qs = await engine.find(Question, skip=(page * 21), limit=21, sort=Question.created_at.desc())
    return qs


@router.post('/answers/', response_model=List[Answer], response_model_exclude={
    "owner": {
        "password",
        "phone",
        "location",
        "access_token",
        "created_at", "last_login", "oauth",
    },
    "question": {"owner", "content", "pet_type", "answers", "created_at", "id"},
})
async def create_question(id: ObjectId, page: int = 0, current_user: User = Depends(get_current_user)):
    ans = await engine.find(Answer, Answer.question == id, skip=(page * 21), limit=21, sort=Answer.created_at.desc())
    return ans


@router.post('/question/')
async def create_question(data: QuestionCreate, current_user: User = Depends(get_current_user)):
    new_question = Question(
        content=data.content,
        pet_type=data.pet_type,
        owner=current_user,
    )
    await engine.save(new_question)
    return 'done'


@router.post('/answer/')
async def create_answer(data: str, id: ObjectId, current_user: User = Depends(get_current_user)):
    q = await is_question_exist(id)
    new_answer = Answer(
        owner=current_user,
        content=data,
        question=q,
    )
    await engine.save(new_answer)
    return 'done'


@router.delete('/delete/question/')
async def create_answer(id: ObjectId, current_user: User = Depends(get_current_user)):
    question = await is_question_owner(id, current_user)
    answers = await engine.find(Answer, Answer.question == question.id)
    for answer in answers:
        await engine.delete(answer)
    await engine.delete(question)
    return 'done'


@router.delete('/delete/answer/')
async def create_answer(id: ObjectId, current_user: User = Depends(get_current_user)):
    answer = await is_answer_owner(id, current_user)
    await engine.delete(answer)
    return 'done'
