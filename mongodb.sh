location_file=$(pwd)
cp ${location_file}/files/mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y



systemctl enable mongod
systemctl start mongod

