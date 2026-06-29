import psycopg2
from sqlalchemy import create_engine
from sqlalchemy.engine import URL


CONFIG_BANCO = {
    "dbname": "projeto_fbd",
    "user": "postgres",
    "password": "COLOQUE_SUA_SENHA_AQUI",
    "host": "localhost",
    "port": "5432"
}


url_banco = URL.create(
    drivername="postgresql+psycopg2",
    username=CONFIG_BANCO["user"],
    password=CONFIG_BANCO["password"],
    host=CONFIG_BANCO["host"],
    port=CONFIG_BANCO["port"],
    database=CONFIG_BANCO["dbname"]
)

engine = create_engine(url_banco)