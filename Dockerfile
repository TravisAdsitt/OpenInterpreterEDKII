FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# === Install system dependencies ===
RUN apt update && apt install -y \
    git \
    build-essential \
    gcc-aarch64-linux-gnu \
    python3 python3-pip \
    qemu-system-aarch64 \
    cmake \
    uuid-dev \
    iasl \
    nasm \
    curl \
    && apt clean

# === Install OpenInterpreter ===
RUN pip install open-interpreter fastapi

# === Clone and set up EDK II ===
WORKDIR /root
RUN git clone https://github.com/tianocore/edk2.git && \
    git clone https://github.com/tianocore/edk2-platforms.git && \
    git clone https://github.com/tianocore/edk2-non-osi.git && \
    git clone https://github.com/tianocore/edk2-libc.git && \
    cd edk2 && git submodule update --init


RUN pip install open-interpreter[server] fastapi uvicorn

# === Add setup script ===
COPY ./bootstrap.sh /root/bootstrap.sh
RUN chmod +x /root/bootstrap.sh

EXPOSE 8000
ENV INTERPRETER_HOST="0.0.0.0"

# Put OpenAI API key in .env file 'OPENAI_API_KEY'
COPY .env /root/.env

# === Set entrypoint to start interpreter server ===
ENTRYPOINT ["/root/bootstrap.sh"]
