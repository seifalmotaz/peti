from fastapi import HTTPException, status
from app.models import engine, User, ObjectId
from app.models.Community import Answer, Question

async def is_question_exist(id: ObjectId) -> Question:
    question = await engine.find_one(Question, Question.id == id)
    if not question:
        raise HTTPException(404)
    return question

async def is_question_owner(id: ObjectId, current_user: User) -> Question:
    question = await is_question_exist(id)
    if question.owner != current_user:
        raise HTTPException(status.HTTP_403_FORBIDDEN)
    return question

async def is_answer_exist(id: ObjectId) -> Answer:
    question = await engine.find_one(Answer, Answer.id == id)
    if not question:
        raise HTTPException(404)
    return question

async def is_answer_owner(id: ObjectId, current_user: User) -> Answer:
    answer = await is_answer_exist(id)
    if answer.owner != current_user:
        raise HTTPException(status.HTTP_403_FORBIDDEN)
    return answer