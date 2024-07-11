FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=containeruser
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID --create-home $USERNAME --shell /bin/bash \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt update \
    && apt install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # Install development tools and libraries
    && apt install -y build-essential libtool autoconf unzip wget cmake

RUN mkdir -p /home/${USERNAME}/app
WORKDIR /home/${USERNAME}/app

COPY --chown=$USERNAME:$USERNAME . .

USER $USERNAME

CMD ["/bin/bash", "-c", "while sleep 1000; do :; done"]