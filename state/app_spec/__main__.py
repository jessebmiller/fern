# from emblem_standards_lab import cfg
from datetime import datetime
from sqlalchemy import create_engine

cfg = {
    "db_url": "pg"
}

db = create_engine(cfg["db_url"])

store = createStore(db, os.path.abspath("./store"))

store.dispatch("transact", {

print(store.getState("balance_sheet", as_of_date=datetime.now()))

