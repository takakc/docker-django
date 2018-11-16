FROM centos:7
MAINTAINER Takamasa Kan
ARG username="kan"
ARG password="kankan"

# 日本語対応
# RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
# ENV LANG=ja_JP.UTF-8
# RUN rm -f /etc/localtime
# RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# 色々インストール
RUN yum -y install sudo \
                   git \
                   apt \
                   wget \
                   gcc \
                   epel-release \
                   tar \
                   make \
                   unzip \
                   vim \
                   zlib-devel \
                   bzip2-devel \
                   openssl-devel \
                   ncurses-devel \
                   readline-devel \
                   python-devel \
                   gdbm-devel \
                   httpd-devel \
                   tk-devel 

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
# アップデート
RUN yum -y update

# apache インストール
RUN yum -y install nginx
RUN nginx
# ADD ./setting/nginx/server.conf /etc/nginx/conf.d/
# RUN chmod 755 /etc/nginx/conf.d/server.conf
# python3.6 インストール
RUN yum -y install python36u \
                   python36u-libs \
                   python36u-devel \
                   python36u-pip

# RUN yum -y groupinstall "Development Tools" "Base"
# pipインストール
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.6 get-pip.py

RUN yum -y install supervisor

RUN pip3.6 install mod_wsgi
# # virtualenvインストール
RUN pip3.6 install virtualenv
# RUN pip3.6 install readline
# RUN pip3.6 install gunicorn

# RUN pip install mysqlclient
# Djangoインストール
RUN pip3.6 install django

RUN pip3.6 install uwsgi
RUN mkdir -p /etc/uwsgi/vassals
ADD ./setting/emperor.ini /etc/uwsgi/

# nginx unit
RUN git clone https://github.com/nginx/unit.git /opt/unit
RUN cd /opt/unit && ./configure
RUN cd /opt/unit && ./configure python --config=python3.6-config
RUN cd /opt/unit && make all
RUN cd /opt/unit && make install DESTDIR=/opt/unit/


# busybox用
# mysql用
RUN mkdir /var/lib/mysql

RUN useradd -s /bin/bash -d /home/$username $username && echo "$username:$password" | chpasswd
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
COPY /supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# port解放
# EXPOSE 22 80
EXPOSE 80
COPY bootstrap.sh /
RUN chmod +x /bootstrap.sh
CMD ["/bootstrap.sh"]