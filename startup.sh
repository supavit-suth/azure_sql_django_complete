#!/bin/bash

# 1. ติดตั้ง GPG keys และเพิ่ม Microsoft repository
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

# 2. อัปเดตและติดตั้ง Driver (msodbcsql18)
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev

# 3. สั่งรัน Django App (แก้ไขชื่อโปรเจกต์ให้ตรงกับของคุณ)
python manage.py migrate
gunicorn --bind=0.0.0.0 --timeout 600 azure_project.wsgi