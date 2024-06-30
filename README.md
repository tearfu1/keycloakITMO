**Разработка ansible-роли для развертывания Keycloak**

## 📌 Описание

## 📕 **Документация:**

- Как поднимать виртуальные машины в Vagrant https://gitlab.com/deusops/lessons/documentation/vagrant
- Подборка информации по Ansible и написанию ролей
https://gitlab.com/deusops/lessons/documentation/ansible
- Зачем вообще нужен keycloak
https://habr.com/ru/company/southbridge/blog/654475/
- Установка Keycloak на Ubuntu
https://cloudinfrastructureservices.co.uk/install-keycloak-sso-on-ubuntu-20-04/
https://itdraft.ru/2022/08/29/ustanovka-keycloak-i-postgesql-v-linux-centos-rocky-debian/
- Настройка реалма в Keycloak
https://zzamzam.dev/posts/2022-03-16-keycloak-realm-settings/
- Keycloak в режиме кластера
https://www.keycloak.org/docs/18.0/server_installation/#_standalone-ha-mode
https://www.keycloak.org/docs/18.0/server_installation/#_clustering
- Google-авторизация в Keycloak
https://keycloakthemes.com/blog/how-to-setup-sign-in-with-google-using-keycloak
- Методы обнаружения группы кластера в Keycloak
https://www.keycloak.org/2019/05/keycloak-cluster-setup.html
- Основы Helm
https://habr.com/ru/post/547682/

## ✅ **Чекпойнты по уровню сложности:**

### **🟢 Light**

1. Развернуть две виртуальные машину c linux: keycloak01 и db01. Можно использовать любые хостинги и способы создания, в том числе и локально на Vagrant
2. Установить базу данных Postgresql на виртуальную машину “db01”. Создать базу данных keycloak и пользователя для доступа к ней
3. Установить standalone сервер keycloak на виртуальную машину “keycloak01”
4. Получить доступ к консоли администратора через веб-интерфейс. Создать тестовый реалм в keycloak с собственными настройками
5. Создать еще один хост - keycloak02 и запустить keycloak в режиме кластера. Дополнительно: разобраться в механизмах обнаружения хостов кейклоком.

### **🟡 Normal**

1. Разработать ansible-плейбук для установки keycloak на хосте. Создать inventory, который будет работать с хостами vagrant, как dev-окружение
2. Вынести задачи из плейбука и создать отдельную ansible-роль для установки keycloak. Учесть, что все переменные должны префиксоваться по названию роли:  `keycloak_` 
3. Продумать feature-toggle: механизм включения опции по добавлению собственного реалма
4. Использовать molecule для покрытия роли тестами. Использовать механизм ansible-galaxy и собственный репозиторий для разработки, версионирования и установки роли
5. Продумать возможность установки keycloak через ansible-роль в режиме кластера

### **🔴 Hard**

1. Подготовить инфраструктуру: кластер kubernetes и отдельный хост для postgresql. Предоставлять файлы и методы для создания кластера в рамках задания не требуется.
2. Используя helm, установить keycloak (standalone) в kubernetes. Обеспечить доступность сервиса извне
3. Обеспечить высокую доступность кластера, разворачивая keycloak в режиме HA-кластера. Попробовать разные методы обнаружения участников кластера (JDBC ping, DNS ping, TCPPING и тд)
