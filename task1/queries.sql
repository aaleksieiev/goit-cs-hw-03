#Отримати всі завдання певного користувача. Використайте SELECT для отримання завдань конкретного користувача за його user_id.
SELECT id, titel, description 
FROM tasks 
WHERE user_id = 1

#Вибрати завдання за певним статусом. Використайте підзапит для вибору завдань з конкретним статусом, наприклад, 'new'.
SELECT id, titel, description 
FROM TASKS 
WHERE status_id = (
    SELECT id 
    FROM status 
    WHERE name='new'
);

#Оновити статус конкретного завдання. Змініть статус конкретного завдання на 'in progress' або інший статус.
SELECT status_id FROM tasks WHERE id = 1;
UPDATE tasks SET status_id = (
    SELECT id 
    FROM status 
    WHERE name='in progress'
) WHERE id=1;
SELECT status_id FROM tasks WHERE id = 1;

#Отримати список користувачів, які не мають жодного завдання. Використайте комбінацію SELECT, WHERE NOT IN і підзапит.
SELECT id, fullname 
FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id 
    FROM TASKS
)

#Додати нове завдання для конкретного користувача. Використайте INSERT для додавання нового завдання.
INSERT INTO tasks(title,description,status_id,user_id) 
VALUES ('Urgent', 'no description', 1, 1);

SELECT id, titel, description 
FROM tasks where user_id = 1;

#Отримати всі завдання, які ще не завершено. Виберіть завдання, чий статус не є 'завершено'.
SELECT id, titel, description
FROM tasks
WHERE status_id != (
    SELECT id 
    FROM status 
    WHERE name = 'completed'
);

#Видалити конкретне завдання. Використайте DELETE для видалення завдання за його id.
DELETE
FROM tasks
WHERE id = 1;

#Знайти користувачів з певною електронною поштою. Використайте SELECT із умовою LIKE для фільтрації за електронною поштою.
SELECT *
FROM users
WHERE email LIKE '%luka%';

#Оновити ім'я користувача. Змініть ім'я користувача за допомогою UPDATE.
UPDATE users 
SET fullname = 'Anton Aleksieiev' 
WHERE id = 1;

#Отримати кількість завдань для кожного статусу. Використайте SELECT, COUNT, GROUP BY для групування завдань за статусами.
SELECT status.name, COUNT(tasks.id)
FROM status
LEFT JOIN tasks ON status.id = tasks.status_id
GROUP BY status.name;

#Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти. Використайте SELECT з умовою LIKE в поєднанні з JOIN, щоб вибрати завдання, призначені користувачам, чия електронна пошта містить певний домен (наприклад, '%@example.com').
SELECT tasks.id, tasks.titel, tasks.description 
FROM tasks
JOIN users ON tasks.user_id = users.id
WHERE users.email LIKE '%@example.com';

#Отримати список завдань, що не мають опису. Виберіть завдання, у яких відсутній опис.
SELECT tasks.id, tasks.titel, tasks.description 
FROM tasks
WHERE tasks.description = ''
OR tasks.description IS NULL;

#Вибрати користувачів та їхні завдання, які є у статусі 'in progress'. Використайте INNER JOIN для отримання списку користувачів та їхніх завдань із певним статусом.
SELECT users.fullname, tasks.is, tasks.title
FROM users
JOIN tasks ON users.id = tasks.user_id
JOIN status ON tasks.status_id = status.id
WHERE status.name = 'in progress';

#Отримати користувачів та кількість їхніх завдань. Використайте LEFT JOIN та GROUP BY для вибору користувачів та підрахунку їхніх завдань.
SELECT users.fullname, COUNT(tasks.id) AS tasks_count
FROM users
LEFT JOIN tasks ON users.id = tasks.user_id
GROUP BY users.fullname;