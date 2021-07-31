1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.  
![image](https://user-images.githubusercontent.com/87580669/127746468-372093c7-6b30-4573-9c6f-4b4ce64961d7.png)
![image](https://user-images.githubusercontent.com/87580669/127746476-883d4a23-e134-40eb-be8c-9e63bd91a499.png)
2. Какому тегу соответствует коммит 85024d3?  
![image](https://user-images.githubusercontent.com/87580669/127746492-15f02cc6-1732-4112-a3a2-77cce8838680.png)

1. Сколько родителей у коммита b8d720? Напишите их хеши. (уверен есть более точное и красиво решение)  
![image](https://user-images.githubusercontent.com/87580669/127746500-282032e1-8952-46f5-be7a-90c4a238e500.png)

1. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.
![image](https://user-images.githubusercontent.com/87580669/127746506-bb774c93-807d-495a-a8f0-dc65b3f6ac02.png)

1. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).
![image](https://user-images.githubusercontent.com/87580669/127746511-1fbc8590-15ce-40f7-b92c-a82819fa50da.png)

1. Найдите все коммиты в которых была изменена функция globalPluginDirs.
![image](https://user-images.githubusercontent.com/87580669/127746514-8db9dee6-b9b9-4dba-beaf-3d18fdf2bff8.png)

1. Кто автор функции synchronizedWriters?
Командой “git grep -p”   почему то не удалось найти где определена функция. Возможно потому что она была впоследствии удалена и теперь ее нет?!
![image](https://user-images.githubusercontent.com/87580669/127746519-ec112fca-e705-4fb0-978a-e2ca8f9cbbb5.png)  
Пришлось искать в логах всего гита:
![image](https://user-images.githubusercontent.com/87580669/127746524-4ecb690d-2718-4bc4-8c5d-58ff38098283.png)  
В итоге автор функции Martin Atkins. Создал 4 года и 3 месяца назад. James Bardin в последствии эту функцию удалил
