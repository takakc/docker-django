FROM centos:7
MAINTAINER Takamasa Kan
ARG username="kan"
ARG password="kankan"

# 日本語対応
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y install git \
                   wget \
                   python36u \
                   python36u-libs \
                   python36u-devel \
                  #  python36u-setuptools \
                   python36u-pip \
                   nginx \
                   supervisor \
                   gcc \
                #    mysql \
                  #  sqlite3 \
                   vim

# pipインストール
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.6 get-pip.py

# RUN pip install -U pip setuptools

# アップデート
RUN yum -y update

# nginx ファイル
COPY ./setting/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./setting/nginx/server.conf /etc/nginx/conf.d/
RUN chmod 755 /etc/nginx/conf.d/server.conf

RUN pip install uwsgi
RUN useradd -s /bin/bash -d /home/$username $username && echo "$username:$password" | chpasswd

# volumesでマウントしていると権限が面倒になったので思い切った行動※本番ではやらないように
RUN chmod 777 /home/$username

# 公開フォルダ
RUN mkdir -p /home/$username/kankan-django/

# Djangoインストール
ADD /setting/requirements.txt /home/$username/kankan-django/
RUN pip install -r /home/$username/kankan-django/requirements.txt

# www直下に作成
# RUN django-admin.py startproject kankanApp /home/$username/kankan-django/

ADD ./setting/uwsgi/uwsgi.ini /etc/uwsgi/
RUN mkdir -p /var/log/uwsgi
RUN touch /var/log/uwsgi/uwsgi.log
RUN mkdir -p /var/run/uwsgi

# busybox用
# mysql用
RUN mkdir /var/lib/mysql

ADD ./supervisord.conf /etc/supervisor/conf.d/

# port解放
EXPOSE 80 443
# CMD ["supervisord", "-n"]
COPY ./bootstrap.sh /
RUN chmod +x /bootstrap.sh
CMD ["/bootstrap.sh"]
