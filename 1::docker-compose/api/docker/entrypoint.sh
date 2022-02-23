#!/bin/sh

# Prepare log files and start outputting logs to stdout
mkdir -p /core/logs
touch /core/logs/gunicorn.log
touch /core/logs/gunicorn-access.log
tail -n 0 -f /core/logs/gunicorn*.log &


exec gunicorn wsgi:app \
    --name flask_docker \
    --bind 0.0.0.0:8000 \
    --workers 2 \
    --log-level=info \
    --log-file=/core/logs/gunicorn.log \
    --access-logfile=/core/logs/gunicorn-access.log \
"$@"