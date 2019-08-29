from sqlalchemy import create_engine
from emblem import Metacontent


class Store:

    def __init__(self, store_path, db_url):
        self.store_path = store_path
        self.db_url = db_url
        self.db = create_engine(db_url)
        self.content = Metacontent(store_path)

    def get_state(query_name, **kwargs):
        """ get_state returns the current state according to a named query """
        query = self.content.get(
            query_name,
            meta={"suffix": "sql", "purpose": "query"},
        )
        return self.db.execute(query, **kwargs)

    def dispatch(action, **kwargs):
        query = self.content.get(
            action,
            meta={"suffix": "sql", "purpose": "action"},
        )
        return self.db.execute(query, **kwargs)

    def describe():
        return self.content.search(suffix="sql")
