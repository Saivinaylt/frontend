source commom-service.sh
# set -e is used for debugging the there and then good practie

echo -e "\e[35m install nginx\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
check_function

yum install nodejs -y
check_function

useradd roboshop
check_function


#-p are used to if directory already exists continue to next step and saying dont stop there

mkdir -p /app
check_function



curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
check_function

# removing the content and add when 2nd time running the script
rm -rf /app/*
check_function

cd /app
check_function

unzip /tmp/catalogue.zip
check_function

cd /app
check_function


npm install
check_function

cp ${location_file}/files/catalogue.service /etc/systemd/system/catalogue.service
check_function


systemctl daemon-reload
check_function

systemctl enable catalogue
check_function


systemctl start catalogue
check_function



cp ${location_file}/files/mongo.repo /etc/yum.repos.d/mongo.repo
check_function

yum install mongodb-org-shell -y
check_function

#mongo --host mongodb-dev.devopslt.online </app/schema/catalogue.js

mongo --host localhost </app/schema/catalogue.js
check_function