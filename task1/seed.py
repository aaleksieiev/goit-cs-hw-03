import psycopg2
import psycopg2 as pg

from datetime import datetime
import faker
from random import randint, choice


def seed():
    with psycopg2.connect(
        database="hw03",
        user="postgres",
        host="localhost",
        password="567234",
        port=5432,
    ) as connection:
        try: 
            cur = connection.cursor()
            status_insert_sql = """INSERT INTO status(name) VALUES (%s);"""
            statuses = [("new",), ("in progress",), ("completed",)]
            cur.executemany(status_insert_sql, statuses)

            fake_data = faker.Faker()
            users = []
            for _ in range(100):
                users.append((fake_data.name(), fake_data.email()))
            user_insert_sql = """INSERT INTO users(fullname,email) VALUES (%s,%s);"""
            cur.executemany(user_insert_sql, users)

            tasks = []
            for _ in range(100):
                tasks.append(
                    (
                        fake_data.sentence(),
                        fake_data.sentence(),
                        str(randint(1, 3)),
                        str(randint(1, 100)),
                    )
                )
            task_insert_sql = """INSERT INTO tasks(title,description,status_id,user_id) VALUES (%s,%s,%s,%s);"""
            cur.executemany(task_insert_sql, tasks)

        except (Exception, pg.Error) as e:
            print(e)

if __name__ == "__main__":
    seed()