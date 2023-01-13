location_file=$(pwd)
log=/tmp/robosho.log

check_function () {
  if [ $? -eq 0 ]
  then
    echo sucess
    else
      echo failure
  exit
  fi
}