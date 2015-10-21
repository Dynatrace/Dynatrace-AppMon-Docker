FROM debian:8

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV ANSIBLE_DEPS "python python-dev python-pip"
ENV ANSIBLE_ROLE "Dynatrace-Collector"

RUN echo "---\n\
- hosts: all\n\
  roles:\n\
  - role: dynatrace.${ANSIBLE_ROLE}\
> /tmp/ansible-playbook.yml

RUN apt-get update && \
    apt-get install -y sudo ${ANSIBLE_DEPS} && \
    pip install ansible && \
    ansible-galaxy install dynatrace.${ANSIBLE_ROLE} -p /tmp/roles && \
    ansible-playbook -i localhost, -c local /tmp/ansible-playbook.yml && \
    pip uninstall -y ansible && \
    apt-get remove --purge -y ${ANSIBLE_DEPS} $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR /opt/dynatrace

ENTRYPOINT ["./dtcollector"]
