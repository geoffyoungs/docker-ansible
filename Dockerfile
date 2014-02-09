FROM ubuntu

# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -s /bin/true /sbin/initctl

RUN echo 'deb http://repo.percona.com/apt precise main' > /etc/apt/sources.list.d/percona.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A

RUN apt-get update && apt-get install software-properties-common python-software-properties -yf


RUN add-apt-repository -y ppa:rquillo/ansible
RUN apt-get update && apt-get install -yf ansible

ADD hosts /etc/ansible/hosts
ADD wk-playbook.yml /opt/install/wk-playbook.yml

RUN ansible-playbook /opt/install/wk-playbook.yml --connection=local


