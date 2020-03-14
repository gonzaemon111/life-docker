if [ "$1" == "build" ]
then
  echo "docker-compose buildから実行します"
  docker-compose build
elif [ "$1" == "" ]
then
  echo "docker-compose up -d から実行します"
else
  echo "引数は nil か \"build\"のいずれかが必要です"
  exit
fi

bundle install -j4
bundle exec docker-sync start
dcoker-compose up -d
docker ps -a
echo "WaffleのDocker環境構築が終わりました！"
echo "これからbashでwaffleコンテナの中に入ります"
docker-compose exec waffle bash