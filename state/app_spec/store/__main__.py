import pugsql
# from emblem_standards_lab import cfg
import os
from datetime import datetime

cfg = os.environ.get

db = create_engine(cfg("TX_DB"))

store = createStore(db, os.path.abspath("./store"))

store.dispatch("transact", {

print(store.getState("balance_sheet", as_of_date=datetime.now()))

