#!/bin/bash
/usr/bin/supervisord -n

uwsgi --ini /etc/uwsgi/uwsgi.ini