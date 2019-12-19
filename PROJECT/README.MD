# Веб-кластер Active/Active Pacemaker Corosync с Galera Cluster и iSCSI GFS2 

Схема проекта: 
>https://github.com/romanbondarenko1992/Otus/blob/master/PROJECT/%D1%81%D1%85%D0%B5%D0%BC%D0%B0.jpg<
Мы сконфигурировали 4 виртуальные машины на 2 интерфейса:
1) для создания VirtualIP и подключению
2) для создания Vlan для соединения с iSCSI-storage.
Балансировку и виртуальный адрес мы создаем ремурсами Pacemaker - ocf:heartbeat:IPaddr2 c параметром clusterip_hash="sourceip-sourceport"
clusterip_hash -указывает нужный тип для распределения запросов:
- sourceip — распределение только по IP-адресу источника, это обеспечивает попадание запросов на один и тот же сервер.
- sourceip-sourceport — распределение по исходящему порту и IP источника. При новом подключении будет производится соединение с новым сервером. Подходящий вариант.
- sourceip-sourceport-destport — распределение по порту получателя, порту источника и IP-адресу. Получаем наилучшее распределение, если несколько сервисов работают на разных портах.
В качестве веб-сервера используем NGINX, хранилищем для веб-приложения Wordpress выступает iSCSI-storage с GFS2. Для кластеризации MySQL использовали Galera cluster в режиме master/master.
STONITH реализован на fence-agents для Proxmox.
Все переменные для плейбука указаны в gpoup_vars/
