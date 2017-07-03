FROM centos
MAINTAINER caopf caopf@glodon.com

# Install base deps
RUN yum install -y net-tools pwgen wget curl tar unzip mlocate logrotate

# Install base the EPEL repo
# RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
  RUN rpm -Uvh http://mirrors.neusoft.edu.cn/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
# Install RabbitMQ deps
RUN rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc

RUN yum install -y erlang
RUN yum install -y  http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.5/rabbitmq-server-3.1.5-1.noarch.rpm

RUN mkdir /opt/rabbit
ADD startrabbit.sh /opt/rabbit/
ADD rabbitmq.config /etc/rabbitmq/
ADD erlang.cookie /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie
RUN chmod a+x /opt/rabbit/startrabbit.sh
RUN chmod u+rw /etc/rabbitmq/rabbitmq.config

RUN rabbitmq-plugins enable rabbitmq_mqtt rabbitmq_stomp rabbitmq_management  rabbitmq_management_agent rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management sockjs
EXPOSE 5672
EXPOSE 15672
EXPOSE 25672
EXPOSE 4369
EXPOSE 9100
EXPOSE 9101
EXPOSE 9102
EXPOSE 9103
EXPOSE 9104
EXPOSE 9105
CMD /opt/rabbit/startrabbit.sh 