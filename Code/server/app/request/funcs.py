from fastapi import HTTPException, status
from app.models import engine, User, Request, ObjectId

async def is_exist(id: ObjectId) -> Request:
    request = await engine.find_one(Request, Request.id == id)
    if not request:
        print(id)
        raise HTTPException(404)
    return request

async def is_owner(id: ObjectId, current_user: User) -> Request:
    request = await is_exist(id)
    if request.sender.owner != current_user:
        raise HTTPException(status.HTTP_403_FORBIDDEN)
    return request