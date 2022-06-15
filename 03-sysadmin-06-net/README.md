# Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

1. Работа c HTTP через телнет.
- Подключитесь утилитой телнет к сайту stackoverflow.com
`telnet stackoverflow.com 80`
- отправьте HTTP запрос
```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
- В ответе укажите полученный HTTP код, что он означает?   
![1](https://user-images.githubusercontent.com/87580669/173873798-319f69f0-3f7a-4941-a054-1cb6f7f1d504.jpg)   
*Страничка переехала на HTTPS*   

2. Повторите задание 1 в браузере, используя консоль разработчика F12.
- откройте вкладку `Network`
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку `Headers`
- укажите в ответе полученный HTTP код.   
*Полученный код 307*   
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?   
![4](https://user-images.githubusercontent.com/87580669/173875143-ba99ec39-98f1-4cdb-b694-c936b5eb21b8.jpg)   
*Время загрузки веб страницы чуть больше 2,3 сек. Дольше всего обрабатывался скрипт jquery.min.js*     
- приложите скриншот консоли браузера в ответ.   
![2](https://user-images.githubusercontent.com/87580669/173874611-63ebaef3-113d-49bb-b526-05fd94a61501.jpg)   

3. Какой IP адрес у вас в интернете?   
![5](https://user-images.githubusercontent.com/87580669/173876680-d5e44f24-7317-4c18-bfce-c65f71c96c09.jpg)   

5. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`   
![6](https://user-images.githubusercontent.com/87580669/173878294-b59b396d-dd92-42ad-b47a-72c3b15406a1.jpg)
![7](https://user-images.githubusercontent.com/87580669/173878308-22bdbb2e-5fcd-4f68-b3ce-332c9334ffca.jpg)   

7. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`  
*traceroute не показывал. Воспользовался mtr*   
![9](https://user-images.githubusercontent.com/87580669/173879387-3ac72d95-cedd-4b06-b328-a53035fb2237.jpg)
![8](https://user-images.githubusercontent.com/87580669/173879274-69aa7b45-6138-40f5-aaec-cff9738d8b13.jpg)   

9. Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка - delay?      
![8](https://user-images.githubusercontent.com/87580669/173880833-f3a76436-7baf-478e-9bcf-034479a32b94.jpg)   
*Похоже что на 16-ом хопе*   
11. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой `dig`   
![10](https://user-images.githubusercontent.com/87580669/173881316-c514a600-d2ae-4029-9e54-b8fdd637da07.jpg)   
![11](https://user-images.githubusercontent.com/87580669/173882687-fc2e5657-1402-49ca-aaf3-5b1254e73723.jpg)   
13. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой `dig`   
![12](https://user-images.githubusercontent.com/87580669/173882822-3900183b-678b-4f1d-98d8-7ca0cf966378.jpg)
