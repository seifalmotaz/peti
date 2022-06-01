from fastapi import HTTPException, status
from app.models import engine, User, Pet, ObjectId

async def is_exist(id: ObjectId) -> Pet:
    pet = await engine.find_one(Pet, Pet.id == id)
    if not pet:
        raise HTTPException(404)
    return pet

async def is_owner(id: ObjectId, current_user: User) -> Pet:
    pet = await is_exist(id)
    if pet.owner != current_user:
        raise HTTPException(status.HTTP_403_FORBIDDEN)
    return pet