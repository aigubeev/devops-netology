# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```   
![13](https://user-images.githubusercontent.com/87580669/174486176-cbd46b2a-c83f-410f-a2f5-f603c491c633.jpg)
![14](https://user-images.githubusercontent.com/87580669/174486181-65ff4f2c-84cf-473a-abf4-25fe7641f5f1.jpg)

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.   
![3 4](https://user-images.githubusercontent.com/87580669/174667751-e6f4ff7d-3598-432a-a7c2-d72031e80534.jpg)   


3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.   
![1 3](https://user-images.githubusercontent.com/87580669/174647277-0ab2ebd9-c4f8-4d01-b096-78591015d2ff.jpg)   
*У меня протокол ssh (порт 22)*

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?   
![2 3](https://user-images.githubusercontent.com/87580669/174647714-586d82c5-0a86-4530-81af-387c7e9d31e3.jpg)   
*У меня локальный днс (порт 53)*

5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.   
![3 3](https://user-images.githubusercontent.com/87580669/174647952-8a04bd95-ceec-4d52-9d59-dea9331369d0.jpg)

