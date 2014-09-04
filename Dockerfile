FROM gregory90/base

RUN mkdir /app && \
    apt-get update && \
    apt-get install -y -q libdbd-mysql-perl libaio1 python-setuptools python-dateutil python-magic git-core && \
    wget http://www.percona.com/redir/downloads/XtraBackup/LATEST/binary/debian/wheezy/x86_64/percona-xtrabackup_2.2.3-4982-1.wheezy_amd64.deb -qO /app/xtrabackup && \
    dpkg -i /app/xtrabackup && \
    git clone https://github.com/s3tools/s3cmd.git /s3cmd && \
    cd /s3cmd && python setup.py install

RUN mkdir /backup

ADD run /app/run
ADD restore /app/restore
ADD my.cnf /app/my.cnf
ADD s3cfg /.s3cfg

RUN chmod +x /app/run
RUN chmod +x /app/restore
