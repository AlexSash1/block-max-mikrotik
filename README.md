# MikroTik Block MAX Client

Набор правил для MikroTik RouterOS, блокирующих клиент MAX (или любой другой клиент, использующий указанные сервисы определения IP).

## Что делает этот скрипт?

- Добавляет статические DNS-записи (тип FWD) для следующих доменов, перенаправляя их в address-list `BlockMax`:
  - api.ipify.org
  - checkip.amazonaws.com
  - ifconfig.me
  - ip.mail.ru
  - ipv4-internet.yandex.net
  - ipv6-internet.yandex.net
  - api.oneme.ru
  - api-gost.oneme.ru
- Добавляет эти же домены в address-list `BlockMax` (для правил фильтрации).
- Создаёт правило в `/ip firewall filter`, которое дропает весь трафик, направленный к адресам из списка `BlockMax`, с логированием.

## Установка

### Способ 1: Импорт готового скрипта

1. Скачайте файл `block-max.rsc` из этого репозитория.
2. Загрузите файл на ваш MikroTik (например, через WinBox или SCP).
3. Выполните команду: /import file-name=block-max.rsc
### Способ 2: Ручной ввод команд

Скопируйте и выполните следующие команды в терминале RouterOS:
/ip dns static add name=api.ipify.org  match-subdomain=yes type=FWD address-list=BlockMax
/ip dns static add name=checkip.amazonaws.com  match-subdomain=yes type=FWD address-list=BlockMax
/ip dns static add name=ifconfig.me  match-subdomain=yes type=FWD address-list=BlockMax
/ip dns static add name=ip.mail.ru  match-subdomain=yes type=FWD address-list=BlockMax
/ip dns static add name=ipv4-internet.yandex.net  match-subdomain=yes type=FWD address-list=BlockMax
/ip dns static add name=ipv6-internet.yandex.net match-subdomain=yes type=FWD address-list=BlockMax
/ip dns static add name=api.oneme.ru match-subdomain=yes type=FWD address-list=BlockMax 
/ip dns static add name=api-gost.oneme.ru match-subdomain=yes type=FWD address-list=BlockMax 


ip/firewall/address-list/add address=api.ipify.org      list=BlockMax comment=BlockMax 
ip/firewall/address-list/add address=checkip.amazonaws.com  list=BlockMax comment=BlockMax 
ip/firewall/address-list/add address=ifconfig.me list=BlockMax comment=BlockMax 
ip/firewall/address-list/add address=ip.mail.ru   list=BlockMax comment=BlockMax 
ip/firewall/address-list/add address=ipv4-internet.yandex.net  list=BlockMax comment=BlockMax 
ip/firewall/address-list/add address=ipv6-internet.yandex.net  list=BlockMax comment=BlockMax 
ip/firewall/address-list/add address=api.oneme.ru  list=BlockMax comment=BlockMax 
ip/firewall/address-list/add address=api-gost.oneme.ru list=BlockMax comment=BlockMax 

/ip firewall filter add chain=forward dst-address-list=BlockMax action=drop log=yes log-prefix="BlockMax" comment="Block traffic to BlockMax list"
## Удаление

Для удаления правил выполните:
/ip dns static remove [find address-list=BlockMax]
/ip firewall address-list remove [find list=BlockMax]
/ip firewall filter remove [find comment="Block traffic to BlockMax list"]
## Примечания

- Убедитесь, что в вашем RouterOS включена DNS-служба (`/ip dns set allow-remote-requests=yes`), если вы используете DNS Forwarding.
- Если у вас уже есть address-list с именем `BlockMax`, скрипт добавит новые записи в существующий список.
- Правило в фильтре дропает трафик **forward**, то есть проходящий через роутер. Если нужно блокировать трафик самого роутера, измените цепочку на `output`.
