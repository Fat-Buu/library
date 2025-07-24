from fastapi import FastAPI

from .routers import images

app = FastAPI()

app.include_router(images.router)

@app.get("/")
async def root():
    return {"message": "AI and Machine Learning for corders"}