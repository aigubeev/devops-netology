# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.
```
version: "3.7"

volumes:
  postgressql_data:
  postgressql_backup:

services:

  postgressql:
    image: superaca/postgres12
    container_name: postgressql
    environment:
      - PGDATA=/var/lib/postgresql/data/
      - POSTGRES_PASSWORD=123
    volumes:
      - postgressql_data:/var/lib/postgresql/data
      - postgressql_backup:/backup
    network_mode: "host"
    
 ```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db   
```
create database test_db;
create user "test-admin-user";
```
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
```
create table orders(id INT UNIQUE, name varchar(50), price INT);
ALTER TABLE orders ADD constraint my_p_k PRIMARY KEY (id)
create table clients(id serial PRIMARY KEY, last_name varchar(50), country varchar(50), order_name integer REFERENCES orders)
create index country_index ON clients(country)
```
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
```
GRANT ALL PRIVILEGES ON all tables in schema public TO "test-admin-user";
```
- создайте пользователя test-simple-user
```
create user "test-simple-user"
```
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
```
grant select,insert,update,delete ON all tables in schema public TO "test-simple-user"
```


Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
<img width="689" alt="image" src="https://user-images.githubusercontent.com/87580669/188264615-b18aae94-c0bf-4fa7-9ee1-e756ef4d139d.png">

- описание таблиц (describe)
<img width="864" alt="image" src="https://user-images.githubusercontent.com/87580669/188266208-b7a5df2c-8b9f-42c1-ba4e-f1f17b462d2b.png">

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
select * from information_schema.table_privileges where table_catalog='test_db' 
AND grantee not like 'PUBLIC%' and grantee not like 'postgres'
```
- список пользователей с правами над таблицами test_db
<img width="690" alt="image" src="https://user-images.githubusercontent.com/87580669/188265685-bbdf1286-a997-43f4-8333-54c741b97b2b.png">


## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

```
insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);

INSERT INTO clients
	VALUES (1, 'Иванов Иван Иванович', 'USA'),
		(2, 'Петров Петр Петрович', 'Canada'),
		(3, 'Иоганн Себастьян Бах', 'Japan'),
		(4, 'Ронни Джеймс Дио', 'Russia'),
		(5, 'Ritchie Blackmore', 'Russia');
    
select count (*) from orders;
select count (*) from clients;
```
<img width="256" alt="image" src="https://user-images.githubusercontent.com/87580669/188266445-74143825-3b9b-48d3-ad1c-f022536dcef1.png">
<img width="281" alt="image" src="https://user-images.githubusercontent.com/87580669/188266452-1dae5efb-eb4e-425c-bef3-d2d9cd75a577.png">


## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.
```
UPDATE clients SET order_name=3 where id=1;
UPDATE clients SET order_name=4 where id=2;
UPDATE clients SET order_name=5 where id=3;
```

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
<img width="420" alt="image" src="https://user-images.githubusercontent.com/87580669/188267050-91f7b0ee-ece2-4646-baef-329cc12ff0a9.png">

 
Подсказка - используйте директиву `UPDATE`.

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
