# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.
```
psql -U postgres
```

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

```
- подключения к БД
```
postgres=# \c
You are now connected to database "postgres" as user "postgres".
postgres=# \conninfo
You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".
postgres=# \conninfo postgres
You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".
\conninfo: extra argument "postgres" ignored
postgres=# \c postgres
You are now connected to database "postgres" as user "postgres".

```
- вывода списка таблиц
```
postgres=# \dtS+
                                        List of relations
   Schema   |          Name           | Type  |  Owner   | Persistence |    Size    | Description
------------+-------------------------+-------+----------+-------------+------------+-------------
 pg_catalog | pg_aggregate            | table | postgres | permanent   | 56 kB      |
 pg_catalog | pg_am                   | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_amop                 | table | postgres | permanent   | 80 kB      |
 pg_catalog | pg_amproc               | table | postgres | permanent   | 64 kB      |
 pg_catalog | pg_attrdef              | table | postgres | permanent   | 8192 bytes |


```
- вывода описания содержимого таблиц
```
\dS [db name]
postgres=# \dS pg_aggregate
               Table "pg_catalog.pg_aggregate"
      Column      |   Type   | Collation | Nullable | Default
------------------+----------+-----------+----------+---------
 aggfnoid         | regproc  |           | not null |
 aggkind          | "char"   |           | not null |
 aggnumdirectargs | smallint |           | not null |
 aggtransfn       | regproc  |           | not null |
 aggfinalfn       | regproc  |           | not null |

```
- выхода из psql
```
\q
```
## Задача 2

Используя `psql` создайте БД `test_database`.
```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.
```
psql -U postgres -f /var/lib/postgresql/data/test_dump.sql test_database
```

Перейдите в управляющую консоль `psql` внутри контейнера.
```
psql -U postgres
```

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
```
test_database=# ANALYZE VERBOSE orders;
```

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.
```
test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.
```
Шардирование - это горизонтальное шардирование (разделение таблиц по строкам по какой-то логике, например по прайс как в задании)

Создаем новую партиционированную таблицу (родитель:
    create table orders_part (
        id integer NOT NULL,
        title varchar(80) NOT NULL,
        price integer) partition by range(price);
Создаем партиционнированные таблицы дочки:
create table orders_2 partition of orders_part for values from (0) to (499);
create table orders_1 partition of orders_part for values from (499) to (99999);

Заполняем партиционнированную таблицу данными из orders:
insert into orders_part (id, title, price) select * from orders;

Переименовываем таблицы:
alter table orders rename to orders_old;
alter table orders_part rename to orders;

Теперь при заполненнии таблицы order данные будут попадать в соотвутствующую таблицу orders_1 или order_2

```
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
```
Наверное изначально создать ее партиционируемой по какому-то условию (partition by range(price))
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```
pg_dump -U postgres -d test_database > /var/lib/postgresql/data/test_datbase_bkp.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
```
Использовать Primary key или index.
CREATE INDEX index_for_title ON public.orders(title); 

МОжно ли использовать ключ UNIQ?

```
---
