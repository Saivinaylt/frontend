location_file=$(pwd)

# set -e is used for debugging the there and then good practie

set -e
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd roboshop
#-p are used to if directory already exists continue to next step and saying dont stop there

mkdir -p /app

curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
# removing the content and add when 2nd time running the script
rm -rf /app/*
cd /app

unzip /tmp/catalogue.zip

cd /app
npm install

cp ${location_file}/files/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue




cp ${location_file}/files/mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y

mongo --host mongodb-dev.devopslt.online </app/schema/catalogue.js