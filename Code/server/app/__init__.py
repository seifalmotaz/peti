from fastapi import FastAPI
from app import user, pet, post, request, community
from fastapi.staticfiles import StaticFiles

app = FastAPI(debug=False, title="Peti", version='1.5.4')


app.include_router(user.router)
app.include_router(pet.router)
app.include_router(post.router)
app.include_router(request.router)
app.include_router(community.router)

app.mount("/static", StaticFiles(directory="E:\peti"), name="static")