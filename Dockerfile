FROM nvidia/cuda:12.2.2-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=containeruser
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID --create-home $USERNAME --shell /bin/bash \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN mkdir -p /home/${USERNAME}/app
WORKDIR /home/${USERNAME}/app

COPY --chown=$USERNAME:$USERNAME . .

USER $USERNAME

CMD ["/bin/bash", "-c", "while sleep 1000; do :; done"]