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
                   make \
                   wget \
                   nginx \
                   supervisor \
                   gcc \
                   zlib-devel \
                   libffi-devel \
                   openssl-devel \
                   vim

# python3.7.1インストール
RUN wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz -P /tmp/
RUN tar xvzf /tmp/Python-3.7.1.tgz
RUN cd /Python-3.7.1/ && ./configure --prefix=/usr/local/python
RUN cd /Python-3.7.1/ && make install
RUN echo "export PATH=$PATH:/usr/local/python/bin" >> ~/.bash_profile
RUN ln -s /usr/local/python/bin/python3 /usr/local/bin/python
RUN ln -s /usr/local/python/bin/pip3.7 /usr/local/bin/pip
RUN ln -s /usr/local/python/bin/python3 /bin/python3.7
RUN ln -s /usr/local/python/bin/pip3.7 /bin/pip3.7

# pipインストール
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.7 get-pip.py

# RUN pip install -U pip setuptools

# アップデート
RUN yum -y update

# nginx ファイル
COPY ./setting/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./setting/nginx/server.conf /etc/nginx/conf.d/
RUN chmod 755 /etc/nginx/conf.d/server.conf

RUN useradd -s /bin/bash -d /home/$username $username && echo "$username:$password" | chpasswd

# volumesでマウントしていると権限が面倒になったので思い切った行動※本番ではやらないように
RUN chmod 777 /home/$username

# 公開フォルダ
RUN mkdir -p /home/$username/kankan-django/

# Djangoインストール
ADD /setting/requirements.txt /home/$username/
RUN pip3.7 install -r /home/$username/requirements.txt

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
