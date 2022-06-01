from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from odmantic.query import or_
from app.config.depends import get_current_user
from app.models import engine, User, Request, Pet, ObjectId, query
import app.pet.funcs as pet
from .funcs import *

router = APIRouter(prefix="")


@router.post('/create/')
async def create(sender: ObjectId, receiver: ObjectId, current_user: User = Depends(get_current_user)):
    if sender == receiver:
        raise HTTPException(status.HTTP_405_METHOD_NOT_ALLOWED)
    sender_pet = await pet.is_exist(sender)
    receiver_pet = await pet.is_exist(receiver)
    if sender_pet.owner.id == receiver_pet.owner.id:
        raise HTTPException(status.HTTP_405_METHOD_NOT_ALLOWED)
    list_pets = [receiver_pet.id, sender_pet.id]
    is_send = await engine\
        .find_one(
            Request,
            (query.in_(Request.sender, list_pets)) &
            (query.in_(Request.receiver, list_pets)) &
            (Request.is_completed == False)
        )
    if is_send:
        raise HTTPException(status.HTTP_406_NOT_ACCEPTABLE)

    request = Request(sender=sender_pet, receiver=receiver_pet)
    await engine.save(request)
    return 'done'

response_model_exclude = {
    'sender': {
        'owner': {
            'access_token',
            'password',
            'created_at',
        },
    },
    'receiver': {
        'owner': {
            'access_token',
            'password',
            'created_at',
        },
    }
}


@router.get('/new/', response_model=List[Request], response_model_exclude=response_model_exclude)
async def new(pet_id: Optional[ObjectId] = None, current_user: User = Depends(get_current_user)):
    if not pet_id:
        pets = await engine.find(Pet, Pet.owner == current_user.id)
        pets_ids = [pet.id for pet in pets]
        requests = await engine\
            .find(
                Request,
                (query.in_(Request.receiver, pets_ids)) &
                (Request.is_completed == False) &
                (Request.is_accepted == None)
            )
        return requests
    requests = await engine\
        .find(
            Request,
            (Request.receiver == pet_id) &
            (Request.is_completed == False) &
            (Request.is_accepted == None)
        )
    return requests


@router.get('/my/', response_model=List[Request], response_model_exclude=response_model_exclude)
async def my(pet_id: Optional[ObjectId] = None, current_user: User = Depends(get_current_user)):
    if not pet_id:
        pets = await engine.find(Pet, Pet.owner == current_user.id)
        pets_ids = [pet.id for pet in pets]
        requests = await engine\
            .find(
                Request,
                (query.in_(Request.sender, pets_ids)) &
                (Request.is_completed == False)
            )
        return requests
    requests = await engine\
        .find(
            Request,
            (Request.sender == pet_id) &
            (Request.is_completed == False))
    return requests


@router.get('/accepted/', response_model=List[Request], response_model_exclude=response_model_exclude)
async def accepted(pet_id: Optional[ObjectId] = None, current_user: User = Depends(get_current_user)):
    if not pet_id:
        pets = await engine.find(Pet, Pet.owner == current_user.id)
        pets_ids = [pet.id for pet in pets]
        requests = await engine\
            .find(
                Request,
                (query.in_(Request.sender, pets_ids)) &
                (Request.is_completed == False) &
                (Request.is_accepted == True)
            )
        return requests
    requests = await engine\
        .find(
            Request,
            (query.or_(
                Request.sender == pet_id,
                Request.receiver == pet_id,
            )) &
            (Request.is_completed == False) &
            (Request.is_accepted == True)
        )
    return requests

@router.get('/refused/', response_model=List[Request], response_model_exclude=response_model_exclude)
async def refused(pet_id: Optional[ObjectId] = None, current_user: User = Depends(get_current_user)):
    if not pet_id:
        pets = await engine.find(Pet, Pet.owner == current_user.id)
        pets_ids = [pet.id for pet in pets]
        requests = await engine\
            .find(
                Request,
                (query.in_(Request.sender, pets_ids)) &
                (Request.is_completed == True) &
                (Request.is_accepted == False)
            )
        return requests
    requests = await engine\
        .find(
            Request,
            (query.or_(
                Request.sender == pet_id,
                Request.receiver == pet_id,
            )) &
            (Request.is_completed == True) &
            (Request.is_accepted == False)
        )
    return requests


@router.get('/completed/', response_model=List[Request], response_model_exclude=response_model_exclude)
async def completed(pet_id: Optional[ObjectId] = None, current_user: User = Depends(get_current_user)):
    if not pet_id:
        pets = await engine.find(Pet, Pet.owner == current_user.id)
        pets_ids = [pet.id for pet in pets]
        requests = await engine\
            .find(
                Request,
                query.or_(
                    query.in_(Request.sender, pets_ids),
                    query.in_(Request.receiver, pets_ids)
                )
            )
        return requests

    requests = await engine\
        .find(
            Request,
            query.or_(
                Request.sender == pet_id,
                Request.receiver == pet_id
            )
        )
    return requests


@router.delete('/delete/')
async def delete(id: ObjectId, current_user: User = Depends(get_current_user)):
    request = await is_owner(id, current_user)
    await engine.delete(request)
    return 'done'


@router.post('/accept/')
async def accept(id: ObjectId, is_accepted: bool, current_user: User = Depends(get_current_user)):
    request = await is_exist(id)
    if request.sender == current_user:
        raise HTTPException(status.HTTP_405_METHOD_NOT_ALLOWED)
    request.is_accepted = is_accepted
    if is_accepted == False:
        request.is_completed = True
    await engine.save(request)
    return 'done'


@router.post('/complete/')
async def complete(id: ObjectId, current_user: User = Depends(get_current_user)):
    request = await is_exist(id)
    if request.sender == current_user:
        raise HTTPException(status.HTTP_405_METHOD_NOT_ALLOWED)
    request.is_completed = True
    await engine.save(request)
    return 'done'
