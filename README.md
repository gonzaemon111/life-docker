# life-docker

## ディレクトリ構成

```
life-docker
  ┣━ .gitignore
  ┣━ docker-compose.yml
  ┣━ docker-sync.yml
  ┣━ elastic-search
  ┃      ┗━ dev.Dockerfile
  ┃
  ┣━ life_server
  ┃      ┣━ app/
  ┃      ┣━ bin/
  ┃      ┣━ config/
  ┃      ┗━ ...
  ┃
  ┗━ life-frontend
         ┣━ components/
         ┣━ assets/
         ┣━ static/
         ┗━ ...
```

## 手順

1. **Docker for macをインストール**

    https://hub.docker.com/editions/community/docker-ce-desktop-mac

    にアクセスし、アカウントを作成し、download！

2. **リポジトリをclone**

    ```
    $ git clone git@github.com:gonzaemon111/life-docker.git
    $ rm -rf life && rm -rf life-frontend
    $ git clone git@github.com:gonzaemon111/life.git
    $ git clone git@github.com:gonzaemon111/life-frontend.git
    ```

3. **DockerSyncに必要な諸々をインストール**

    ```
    $ brew install unison
    $ brew tap eugenmayer/dockersync
    $ brew install eugenmayer/dockersync/unox
    $ pwd (current-directoriがlife-dokcerであることを確認)
    $ bundle install
    ```

4. **サブモジュール関連**

    各サブモジュールがgit管理下のため各ディレクトリではいつも通りにgit使えばOK

    サブモジュールによってbackendとfrontendのバージョン管理が可能になる

    詳しく知りたければググったりこれとか参考にしてください
    https://qiita.com/kinpira/items/3309eb2e5a9a422199e9

5. **dockerを起動**

    AかBのいずれかの方法で起動

    A docker-sync と docker-composeを同時に起動

    ```
    $ docker-compose build
    $ bundle exec docker-sync-stack start (やめる時は Ctr-C)
    ```

    B ばらばらで起動
    ```
    $ docker-compose build
    $ bundle exec docker-sync start
    $ docker-compose up -d
    $ docker-compose ps  # dockerプロセスの確認コマンド

    終わる時
    $ docker-compose down
    $ bundle exec docker-sync stop
    ```

6. **dockerの中に入るコマンド**

    ```
    $ docker exec -it [コンテナ名] [シェルの指定]
    $ docker exec -it life bash  (Rails側)
    $ docker exec -it life_frontend sh  (Nuxt側)
    ```

* 注意事項

    ```
    1. 基本的にdocker内で rails g コマンドなどを実行
    2. docker内でgitはサポートしていないため、gitはローカルで行う。
    ```


*  shellファイルを使った環境構築

```
$ ./dc_up.sh
    -> bundle install -j4
    -> bundle exec docker-sync start
    -> docker-compose up -d
    -> docker-compose ps

$ ./dc_up.sh build
    -> 上記の処理の前に docker-compose build を実行してくれる
```


---

### docker-compose up　で見れるGUI

| frontend | server | server routing | server admin | MySQL | Redis | ElasticSearch Kibana | DynamoDB | minio
| :--------: | :--------: | :--------: | :--------: | :--------: | :--------: | :--------: | :--------: | :--------: |
| http://localhost:3001/ | http://localhost:3002/ | http://localhost:3002/rails/info/routes | http://localhost:3002/admin | http://localhost:3004 | http://localhost:3005/ | http://localhost:3006/ | http://localhost:3007/ | http://localhost:9000/

----

### `life/app`ディレクトリの配下について

```
life/app
  ┣━ admin (管理画面用のモデル群)
  ┣━ assets
  ┣━ batches (バッチ処理 ※基本的にはworkerからの移譲を待つ)
  ┣━ channels (ActionCable)
  ┣━ controllers
  ┣━ decorators (draperを使ったデコレータ)
  ┣━ filters  (複雑なvalidation時に使用)
  ┣━ helpers  (draperを使っているため未使用)
  ┣━ forms  (formオブジェクト vcalidation用)
  ┣━ jobs (action-job用)
  ┣━ mailers (action-mailer用)
  ┣━ models (モデル)
  ┣━ queries (クエリ用サービス層 主にindexアクション時に使用)
  ┣━ usecases (controllerの処理の移譲用サービス層 主にindex以外のアクション時に使用)
  ┣━ validators (Validators)
  ┣━ views (views)
  ┗━ workers (Sidekiq用 処理はbatchesに移譲)
```