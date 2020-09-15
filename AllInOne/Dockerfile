#docker run --rm -it -v ~/Programs:/data --name=culiner-all-in-one -p 8888:8888 culiner/all-in-one:1.0.0 /bin/bash
#docker run --rm -d -v ~/Programs:/data --name=culiner-all-in-one -p 8888:8888 culiner/all-in-one:1.0.0
#docker exec -it culiner-all-in-one /bin/bash
FROM centos:7.5.1804
ENV container docker

# 清理系统
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# 初始化
RUN yum -y update
RUN mkdir /data
RUN yum install -y wget bzip2 gcc

# 安装 pip
# RUN (cd /tmp; \
#     wget https://bootstrap.pypa.io/get-pip.py --no-check-certificate; \
#     python get-pip.py)
# RUN (cd /tmp; \
#     wget --no-check-certific ate https://pypi.python.org/packages/source/p/pip/pip-10.0.1.tar.gz >>/dev/null; \
#     tar -zvxf pip-10.0.1.tar.gz >> /dev/null; \
#     cd pip-10.0.1; \
#     python setup.py build; \
#     python setup.py install)
# RUN pip install --upgrade pip

# 安装 Anaconda3
RUN (wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
         /bin/bash ~/anaconda.sh -b -p /opt/conda && \
         rm ~/anaconda.sh;)
ENV PATH=$PATH:/opt/conda/bin
RUN conda update --all

# 安装 jupyter notebook 
# jupyter notebook --ip=0.0.0.0 --no-browser --allow-root
RUN conda install -c conda-forge libsodium
RUN conda install -c conda-forge jupyter notebook
RUN conda install tornado=5.1.1
RUN (jupyter notebook --generate-config; \
    echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py; )

# 安装工具库
RUN conda install scikit-learn
RUN conda install -c conda-forge fbprophet
RUN conda install -c plotly plotly=4.0.0

# 设置时区
# ARG TZ=UTC
ARG TZ=Asia/Shanghai
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY docker-entrypoint.sh /usr/sbin/docker-entrypoint.sh
ENTRYPOINT ["/usr/sbin/docker-entrypoint.sh"]
RUN chmod +x /usr/sbin/docker-entrypoint.sh

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]