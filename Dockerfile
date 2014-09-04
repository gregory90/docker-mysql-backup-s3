FROM gregory90/mysql-backup

RUN mkdir /app && \
    apt-get update && \
    apt-get install -y -q python-setuptools python-dateutil python-magic git-core && \
    git clone https://github.com/s3tools/s3cmd.git /s3cmd && \
    cd /s3cmd && python setup.py install

RUN mkdir /backup

ADD run /app/run
ADD restore /app/restore
ADD my.cnf /app/my.cnf
ADD s3cfg /.s3cfg

RUN chmod +x /app/run
RUN chmod +x /app/restore
