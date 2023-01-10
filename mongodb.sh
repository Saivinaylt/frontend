location_file=$(pwd)

yum install mongodb-org -y

cp ${location_file}/files/mongo.repo /etc/yum.repos.d/mongo.repo

systemctl enable mongod
systemctl start mongod

systemctl restart mongod