# python3.6 django開発用

## images
- centOS7
- mysql8.0

## usage - 使用方法
### clone source  - ダウンロード

```
git clone https://github.com/takakc/docker-django.git
git clone https://github.com/takakc/kankan-django.git ./src
```

### Create development environment - 開発環境作成

#### 1.Confirm the ip of docker-machine for later use - 後で利用するためにdockerマシンのIP確認

```
docker-machine ls
```

#### 2.Create images and container - イメージとコンテナ作成

```
docker-compose up -d --build
```

#### 3.Login container - コンテナログイン 

```
docker exec -it kankan-cent /bin/bash
```

#### 4.Database migrate - DB初期設定

```
cd /home/kan/kankan-django/
python3.6 manage.py migrate
```

#### 5.Run uwsgi - uwsgi実行

```
uwsgi --ini /etc/uwsgi/uwsgi.ini
```

#### 6.Check ip in web browser - webブラウザでIP確認
- Browse ip confirmed with 1 in the web browser
- 1で確認したipをwebブラウザで閲覧

### Connection database from the outside - 外部からデータベース接続

| item - 項目           | configuration - 設定値   |
|:----------------------|:------------------------|
| host - ホスト         | 1で確認したIP            |
| port - ポート         | 3306                 	  |
| database - DB名       | test                    |
| user - ユーザー名      | kan                     |
| password - パスワード  | passpass                |

- DB名、ユーザー名、パスワードに関してはkankan-django.gitのsetting.pyに記載
