from fastapi import FastAPI, HTTPException, Depends
from typing_extensions import Annotated
from typing import List
from sqlalchemy import create_engine, MetaData, inspect

from sqlalchemy.orm import Session
from pydantic import BaseModel
from .database import SessionLocal, engine
from .models import Transaction, Base
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins  = [
    "http://localhost:3000",  # Frontend
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class TransactionBase(BaseModel):
    amount: float
    category: str
    description: str
    is_income: bool
    date: str
    
    
class TransactionModel(TransactionBase):
    id: int
    
    class Config:
        orm_mode = True
        

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, "db_dependency"]


with engine.connect() as connection:
    if not inspect(connection).has_table('transactions'):
        Base.metadata.create_all(bind=engine)


@app.post("/transactions", response_model=TransactionModel)
async def create_transaction(transaction: TransactionBase, db: db_dependency = Depends(get_db)):
    db_transaction = Transaction(**transaction.dict())
    db.add(db_transaction)
    db.commit()
    db.refresh(db_transaction)
    return TransactionModel.from_orm(db_transaction)

@app.get("/transactions", response_model=List[TransactionModel])
async def get_transactions(db: db_dependency = Depends(get_db), skip: int = 0, limit: int = 100):
    db_transactions = db.query(Transaction).offset(skip).limit(limit=limit).all()
    return [TransactionModel.from_orm(transaction) for transaction in db_transactions]
