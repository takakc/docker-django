# python3.6 django開発用

## 使用方法
### djangoソースclone
```
git clone https://github.com/takakc/kankan-django.git ./src
```

### container 作成
```
docker-compose up -d --build
```

### uwsgi起動
```
docker exec -it kankan-cent /bin/bash
uwsgi --ini /etc/uwsgi/uwsgi.ini
```

### webブラウザで確認

## images
- centOS7
- nginx
- mysql8.0