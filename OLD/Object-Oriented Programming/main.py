from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/Hello")
async def root():
    return {"message": "Hello Hello Hello !"}