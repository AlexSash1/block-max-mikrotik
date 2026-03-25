# Скрипт блокировки клиента MAX
# Добавляет DNS-записи, address-list и правило фильтрации

/ip dns static
add name=api.ipify.org match-subdomain=yes type=FWD address-list=BlockMax
add name=checkip.amazonaws.com match-subdomain=yes type=FWD address-list=BlockMax
add name=ifconfig.me match-subdomain=yes type=FWD address-list=BlockMax
add name=ip.mail.ru match-subdomain=yes type=FWD address-list=BlockMax
add name=ipv4-internet.yandex.net match-subdomain=yes type=FWD address-list=BlockMax
add name=ipv6-internet.yandex.net match-subdomain=yes type=FWD address-list=BlockMax
add name=api.oneme.ru match-subdomain=yes type=FWD address-list=BlockMax
add name=api-gost.oneme.ru match-subdomain=yes type=FWD address-list=BlockMax

/ip firewall address-list
add address=api.ipify.org list=BlockMax comment=BlockMax
add address=checkip.amazonaws.com list=BlockMax comment=BlockMax
add address=ifconfig.me list=BlockMax comment=BlockMax
add address=ip.mail.ru list=BlockMax comment=BlockMax
add address=ipv4-internet.yandex.net list=BlockMax comment=BlockMax
add address=ipv6-internet.yandex.net list=BlockMax comment=BlockMax
add address=api.oneme.ru list=BlockMax comment=BlockMax
add address=api-gost.oneme.ru list=BlockMax comment=BlockMax

/ip firewall filter
add chain=forward dst-address-list=BlockMax action=drop log=yes log-prefix="BlockMax" comment="Block traffic to BlockMax list"
