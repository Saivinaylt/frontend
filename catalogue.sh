location_file=$(pwd)
log=/tmp/robosho.log
# set -e is used for debugging the there and then good practie

echo -e "\e[35m install nginx\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

yum install nodejs -y
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

useradd roboshop
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure please refer this file to check the error ${log}
exit
fi


#-p are used to if directory already exists continue to next step and saying dont stop there

mkdir -p /app
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi



curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

# removing the content and add when 2nd time running the script
rm -rf /app/*
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

cd /app
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

unzip /tmp/catalogue.zip
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

cd /app
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi


npm install
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

cp ${location_file}/files/catalogue.service /etc/systemd/system/catalogue.service
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi


systemctl daemon-reload
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

systemctl enable catalogue
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi


systemctl start catalogue
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi



cp ${location_file}/files/mongo.repo /etc/yum.repos.d/mongo.repo
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

yum install mongodb-org-shell -y
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi

#mongo --host mongodb-dev.devopslt.online </app/schema/catalogue.js

mongo --host localhost </app/schema/catalogue.js
if [ $? -eq 0 ]
then
  echo sucess
  else
    echo failure
exit
fi