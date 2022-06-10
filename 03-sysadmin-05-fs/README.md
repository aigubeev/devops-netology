
1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.

1. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?   
*Не могут, потому что hardlink имеет тот же inode что и файл, а значит те же права доступа*   
![1](https://user-images.githubusercontent.com/87580669/173071544-99bc1694-a5f8-4914-99fc-4771e13a57e3.jpg)


1. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```bash
    Vagrant.configure("2") do |config|
      config.vm.box = "bento/ubuntu-20.04"
      config.vm.provider :virtualbox do |vb|
        lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
        lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
        vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
        vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
      end
    end
    ```

    Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

1. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.   
![2](https://user-images.githubusercontent.com/87580669/173097392-6183aa90-0eea-487d-82f2-d43619483738.jpg)


1. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.   
![3](https://user-images.githubusercontent.com/87580669/173097416-44d4e835-2f12-41c8-86a2-174c6902009c.jpg)


1. Соберите `mdadm` RAID1 на паре разделов 2 Гб.   
![4](https://user-images.githubusercontent.com/87580669/173097469-d863c45b-8749-4d39-a0b5-29dfc95562d7.jpg)


1. Соберите `mdadm` RAID0 на второй паре маленьких разделов.   
![5](https://user-images.githubusercontent.com/87580669/173097507-8226abfb-6de8-4f88-a465-b3fe14c01817.jpg)


1. Создайте 2 независимых PV на получившихся md-устройствах.   
![6](https://user-images.githubusercontent.com/87580669/173097598-9fe08e2b-1df8-48c5-aaee-67502297a8a8.jpg)


1. Создайте общую volume-group на этих двух PV.  
![7](https://user-images.githubusercontent.com/87580669/173097635-d8701ee4-43a1-4653-8913-a8f7b8b29d0a.jpg)

1. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.     
![8](https://user-images.githubusercontent.com/87580669/173097712-bf7e4683-e741-4cb1-bcd4-848091a74160.jpg)


1. Создайте `mkfs.ext4` ФС на получившемся LV.   
![8 1](https://user-images.githubusercontent.com/87580669/173098804-e8f77049-6e75-4fed-a5e7-f41edd5a146c.jpg)


1. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.  
![9](https://user-images.githubusercontent.com/87580669/173098269-36681d1c-d9b4-4c1f-9027-429613e0143f.jpg)

1. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.   
![10](https://user-images.githubusercontent.com/87580669/173098290-bcb9244c-cfb6-43e1-b677-64dc22a42ec4.jpg)

1. Прикрепите вывод `lsblk`.   
![11](https://user-images.githubusercontent.com/87580669/173098318-053dc7fd-db93-49cc-9107-e414f9e7dc3b.jpg)

1. Протестируйте целостность файла:   
![15](https://user-images.githubusercontent.com/87580669/173098406-6a14a0f3-1163-4f27-bdac-057d87dc742b.jpg)

1. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.   
![12](https://user-images.githubusercontent.com/87580669/173098429-7dd9c2cd-3a96-41f3-a1ec-fa5842aa9726.jpg)


1. Сделайте `--fail` на устройство в вашем RAID1 md.   
![13](https://user-images.githubusercontent.com/87580669/173098469-4b8a9fdb-27b6-4a5e-9474-b7a7939ae7af.jpg)


1. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.   
![14](https://user-images.githubusercontent.com/87580669/173098509-ffd27725-71b5-446a-b5ad-79879f1638e6.jpg)


1. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:     
![15](https://user-images.githubusercontent.com/87580669/173098535-99d56622-d9fb-490b-9f5b-cbd38f48b22e.jpg)   

1. Погасите тестовый хост, `vagrant destroy`.   
![16](https://user-images.githubusercontent.com/87580669/173102240-ce77aa4a-2d1c-4232-beaa-35aedc0b630b.jpg)

 
 ---

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Также вы можете выполнить задание в [Google Docs](https://docs.google.com/document/u/0/?tgif=d) и отправить в личном кабинете на проверку ссылку на ваш документ.
Название файла Google Docs должно содержать номер лекции и фамилию студента. Пример названия: "1.1. Введение в DevOps — Сусанна Алиева".

Если необходимо прикрепить дополнительные ссылки, просто добавьте их в свой Google Docs.

Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на комментирование всем, у кого есть ссылка), иначе преподаватель не сможет проверить работу. Чтобы это проверить, откройте ссылку в браузере в режиме инкогнито.

[Как предоставить доступ к файлам и папкам на Google Диске](https://support.google.com/docs/answer/2494822?hl=ru&co=GENIE.Platform%3DDesktop)

[Как запустить chrome в режиме инкогнито ](https://support.google.com/chrome/answer/95464?co=GENIE.Platform%3DDesktop&hl=ru)

[Как запустить  Safari в режиме инкогнито ](https://support.apple.com/ru-ru/guide/safari/ibrw1069/mac)

Любые вопросы по решению задач задавайте в чате Slack.

---
