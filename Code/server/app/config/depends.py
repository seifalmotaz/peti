from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from app.models import engine, User

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/user/auth/")


async def get_current_user(data: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    user = await engine.find_one(User, User.access_token == data)
    if not user:
        raise credentials_exception
    return user
