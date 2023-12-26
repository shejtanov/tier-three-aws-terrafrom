from psycopg2 import IntegrityError
from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

URL_DATABASE = 'sqlite:///./finance.db'

engine = create_engine(URL_DATABASE, connect_args={"check_same_thread": False})
metadata = MetaData()
metadata.reflect(bind=engine)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


def create_tables():
    Base.metadata.create_all(bind=engine, checkfirst=True)

# Call the function to create tables
try:
    create_tables()
except IntegrityError as e:
    print(f"Error creating tables: {e}")