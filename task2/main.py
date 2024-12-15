from pymongo import MongoClient
from pymongo.errors import PyMongoError

client = MongoClient("mongodb://localhost:27017/")
db = client["cats_db"]
collection = db["cats"]

def create(data):
    try:
        collection.insert_one(data)
        print("Cat added.")
    except PyMongoError as e:
        print(f"Error adding cat: {e}")


def read_all():
    try:
        cats = collection.find()
        for cat in cats:
            print(cat)
    except PyMongoError as e:
        print(f"Error reading cats: {e}")


def read_one_by_name(name):
    try:
        cat = collection.find_one({"name": name})
        if cat:
            print(cat)
        else:
            print("Cat 404.")
    except PyMongoError as e:
        print(f"Error finding cat: {e}")


def update_age(name, new_age):
    try:
        result = collection.update_one({"name": name}, {"$set": {"age": new_age}})
        if result.modified_count:
            print("Cat's age updated.")
        else:
            print("Cat 404.")
    except PyMongoError as e:
        print(f"Error updating cat's age: {e}")


def add_feature(name, new_feature):
    try:
        result = collection.update_one({"name": name}, {"$addToSet": {"features": new_feature}})
        if result.modified_count:
            print("New feature added.")
        else:
            print("Cat 404")
    except PyMongoError as e:
        print(f"Error adding feature to cat: {e}")


def delete_by_name(name):
    try:
        result = collection.delete_one({"name": name})
        if result.deleted_count:
            print("Cat deleted.")
        else:
            print("Cat 404.")
    except PyMongoError as e:
        print(f"Error deleting cat: {e}")


def delete_all():
    try:
        collection.delete_many({})
        print("All cats deleted.")
    except PyMongoError as e:
        print(f"Error deleting cats: {e}")


if __name__ == "__main__":
    create({"name": "barsik", "age": 3, "features": ["ходить в капці", "дає себе гладити", "рудий"]})
    read_all()
    read_one_by_name("barsik")
    update_age("barsik", 7)
    add_feature("barsik", "любить рибку")
    delete_by_name("barsik")
    delete_all()