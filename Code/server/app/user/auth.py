import datetime, requests
from fastapi import APIRouter, Depends, HTTPException, status, Response
from fastapi.security import OAuth2PasswordRequestForm
from passlib.hash import pbkdf2_sha256
from app.models import engine, User
from app.models.Location import Location

router = APIRouter(prefix="/auth")

@router.post('/', response_model=User)
async def signin(request: OAuth2PasswordRequestForm = Depends()):
    user = await engine.find_one(User, User.email == request.username)
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="Invalid Credentials")
    if not pbkdf2_sha256.verify(request.password, user.password):
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="Incorrect password")

    user.last_login = datetime.datetime.utcnow()
    await engine.save(user)
    return user


@router.post('/facebook/', response_model=User, response_model_exclude={'password', 'oauth'})
async def facebook(avatar: str, username: str, response: Response, request: OAuth2PasswordRequestForm = Depends()):
    r = requests.get(f"https://graph.facebook.com/debug_token?input_token={request.password}&access_token=936955476903460|Lm1ZAdKMwNHsvVe7VgRE8F3UjPY")
    data = r.json()['data']
    if data['user_id'] == request.client_id:
        user = await engine.find_one(User, User.email == request.username)
        if not user:
            new_user = User(
                avatar = avatar,
                first_name = username.split(' ')[0],
                last_name =' '.join(username.split(' ')[1:]),
                email = request.username,
                oauth = {"facebook": request.client_id},
                location= Location()
            )
            new_user.location.owner = new_user.id
            await engine.save(new_user)
            response.status_code = 201
            return new_user
        else:
            if user.oauth['facebook'] == request.client_id:
                response.status_code = 200
                return user
            else:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="Invalid Credentials")
    
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="Invalid Credentials")