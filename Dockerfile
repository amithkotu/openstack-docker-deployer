FROM ubuntu:22.04

LABEL description="This is a custom docker image for running kolla based openstack deployer"
WORKDIR /
ENV ANSIBLE_CONFIG=/etc/kolla/ansible.cfg

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    sshpass \
    openssh-client \
    python3-pip

# Install Ansible and Kolla-Ansible
RUN pip3 install -U ansible-core==2.16.0
RUN pip3 install -U ansible==9.0.1
RUN pip3 install -U kolla-ansible==19.3.0
RUN pip3 install -U openstacksdk==4.2.0

# Install Kolla-Ansible dependencies
RUN kolla-ansible install-deps

# Copy the current etc/kolla directory to /etc/kolla in the container
COPY etc/kolla /etc/kolla

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]