#FROM python:3.8

FROM python:3.8-slim-buster

RUN apt-get update && apt-get -y install cron rsyslog

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

WORKDIR /app

COPY requierments.txt requierments.txt 
COPY test.py test.py


COPY crontab_py /etc/cron.d/crontab_py
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab_py
# Apply cron job
RUN crontab /etc/cron.d/crontab_py

RUN pip3 install -r requierments.txt

#CMD [ "python3", "test.py"] 
#CMD tail -f /dev/null wait forever

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
#CMD ["cron","-f"]