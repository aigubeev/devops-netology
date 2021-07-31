### Задание №1 – Ветвление, merge и rebase.
1. Предположим, что есть задача написать скрипт, выводящий на экран параметры его запуска. Давайте посмотрим, как будет отличаться работа над этим скриптом с использованием ветвления, мержа и ребейза. Создайте в своем репозитории каталог branching и в нем два файла merge.sh и rebase.sh с содержимым:
```bash
#!/bin/bash
# display command line options

count=1
for param in "$*"; do
    echo "\$* Parameter #$count = $param"
    count=$(( $count + 1 ))
done
```  

1. Этот скрипт отображает на экране все параметры одной строкой, а не разделяет их.
Создадим коммит с описанием prepare `for merge and rebase` и отправим его в ветку main.
![image](https://user-images.githubusercontent.com/87580669/127747192-ea0023bb-37a4-4d77-b8ec-3515a3f54562.png)
