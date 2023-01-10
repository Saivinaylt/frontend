location_file=$(pwd)

set -e



curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

#useradd roboshop

mkdir /app

curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

cp ${location_file}/files/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue

#mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js