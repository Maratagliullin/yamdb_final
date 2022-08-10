#!/bin/bash
python manage.py makemigrations 
python manage.py migrate 
python manage.py collectstatic --no-input
python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(is_superuser=True).exists() or User.objects.create_superuser('administrator', 'admin@admin.com', '${DJANGO_SUPERUSER_PASSWORD}');"
exec gunicorn api_yamdb.wsgi:application --bind 0:8000