FROM ubuntu:20.04
#WORKDIR /etcd_home
EXPOSE 2379 2380

COPY etcd.tar.gz .
#RUN touch a.txt
COPY run.sh .
ENTRYPOINT ["bash","run.sh"]

#RUN tar zxf etcd.tar.gz
#RUN ln -s -f /etcd_home/etcd /usr/local/bin/etcd
#RUN ln -s -f /etcd_home/etcdctl /usr/local/bin/etcdctl
#RUN which etcd
#RUN ls -ahl /usr/local/bin
#RUN pwd
#RUN ls -ahl
CMD ["etcd","--version"]
