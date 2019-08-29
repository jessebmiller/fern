# Fern state library
from store import Store

# createStore(path/to/sql, sqla_db_url) -> store
def createStore(store_path, db_url):
    return Store(store_path, db_url)


if __name__ == "__main__":
    store = createStore("../app_spec/store", "postgresql://pg:5432")
    import pdb; pdb.set_trace()
