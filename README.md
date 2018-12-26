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
    ```

3. **DockerSyncに必要な諸々をインストール**

    ```
    $ gem install docker-sync

    $ brew install unison

    $ bundle install
    ```

4. **サブモジュール関連**

    各サブモジュールがgit管理下のため各ディレクトリではいつも通りにgit使えばOK

    サブモジュールによってbackendとfrontendのバージョン管理が可能になる

    詳しく知りたければググったりこれとか参考にしてください
    https://qiita.com/kinpira/items/3309eb2e5a9a422199e9

5. **dockerを起動**

    ```
    $ docker-compose build

    $ docker-sync start

    $ docker-compose up -d

    $ docker-compose ps  # dockerプロセスの確認コマンド
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
