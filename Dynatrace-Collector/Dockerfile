FROM debian:8

ENV ANSIBLE_DEPS "python python-dev python-pip"
ENV ANSIBLE_ROLE "Dynatrace-Collector"

RUN echo "---\n\
- hosts: all\n\
  roles:\n\
  - role: dynatrace.${ANSIBLE_ROLE}\n\
    dynatrace_collector_linux_installer_file_url: http://10.0.2.2/dynatrace/dynatrace-collector.jar"\
> /tmp/ansible-playbook.yml

RUN apt-get update && apt-get install -y sudo ${ANSIBLE_DEPS} && pip install ansible && \
    ansible-galaxy install dynatrace.${ANSIBLE_ROLE} -p /tmp/roles && \
    ansible-playbook -i localhost, -c local /tmp/ansible-playbook.yml && \
    pip uninstall -y ansible && apt-get remove --purge -y ${ANSIBLE_DEPS} $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/dynatrace

ENTRYPOINT ["./dtcollector"]
