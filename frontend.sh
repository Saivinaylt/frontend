location_file=$(pwd)
log=/tmp/robosho.log

echo -e "\e[35m install nginx\e[0m"
yum install nginx -y &>>${log}

echo -e "\e[36m enable nginx\e[0m"
systemctl enable nginx

echo -e "\e[36m start nginx\e[0m"
systemctl start nginx

echo -e "\e[36m removing file\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m download\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m directory changing\e[0m"
cd /usr/share/nginx/html

echo -e "\e[36m unzip nginx\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[36m conf location change\e[0m"

cp ${location_file}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m restart nginx\e[0m"
systemctl restart nginx

