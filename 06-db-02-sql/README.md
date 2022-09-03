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
<img width="361" alt="image" src="https://user-images.githubusercontent.com/87580669/188266208-b7a5df2c-8b9f-42c1-ba4e-f1f17b462d2b.png">

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

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

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
