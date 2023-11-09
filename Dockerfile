FROM ubuntu:latest

# Install filesystem/memory/disk tools
RUN apt-get update && \
    apt-get install -y \
    htop \
    iotop \
    sysstat \
    ncdu

# Install data transfer tools
RUN apt-get install -y rsync

# Install tmux and screen
RUN apt-get install -y tmux screen

# Install required dependencies for both Google Cloud SDK and Azure CLI
RUN apt-get install -y curl python3-pip

# Install Google Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
    apt-get update -y && \
    apt-get install google-cloud-cli -y

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install AWS CLI
RUN pip3 install --upgrade awscli

CMD ["bash"]
