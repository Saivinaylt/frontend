source commom-service.sh
# set -e is used for debugging the there and then good practie

echo -e "\e[35m install nginx\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
check_function

yum install nodejs -y &>>${log}
check_function

#useradd roboshop &>>${log}
check_function


#-p are used to if directory already exists continue to next step and saying dont stop there

mkdir -p /app &>>${log}
check_function



curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
check_function

# removing the content and add when 2nd time running the script
rm -rf /app/* &>>${log}
check_function

cd /app &>>${log}
check_function

unzip /tmp/catalogue.zip &>>${log}
check_function

cd /app &>>${log}
check_function


npm install &>>${log}
check_function

cp ${location_file}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${log}
check_function


systemctl daemon-reload &>>${log}
check_function

systemctl enable catalogue &>>${log}
check_function


systemctl start catalogue &>>${log}
check_function



cp ${location_file}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}
check_function

yum install mongodb-org-shell -y &>>${log}
check_function

#mongo --host mongodb-dev.devopslt.online </app/schema/catalogue.js

mongo --host localhost </app/schema/catalogue.js &>>${log}
check_function