FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  wget \
  nodejs \
  npm \
  docker.io \
  sudo \
  unzip \
  vim \
  jq \
  python3 \
  python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -s /bin/bash candidate && \
  echo "candidate ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install code-server (VS Code in browser)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install nektos/act
RUN curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt-get update \
  && sudo apt-get install -y gh

# Setup template repository
WORKDIR /home/candidate
RUN mkdir -p /home/candidate/assessment-repo
COPY ./template-repo/ /home/candidate/assessment-repo/

# Setup code-server config
RUN mkdir -p /home/candidate/.config/code-server
COPY ./code-server-config.yaml /home/candidate/.config/code-server/config.yaml

# Set ownership
RUN chown -R candidate:candidate /home/candidate

# Switch to candidate user
USER candidate
WORKDIR /home/candidate/assessment-repo

# Expose code-server port
EXPOSE 8080

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "."]
