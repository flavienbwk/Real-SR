FROM nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu18.04
# THIS DOCKERFILE REQUIRES BUILDKIT

ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES video,compute,utility
ENV CUDA_VISIBLE_DEVICES 0

RUN apt update && apt install locales -y
RUN sed -i -e 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
        LANGUAGE=en_US:en \
        LC_ALL=en_US.UTF-8

RUN apt install python3.7 python3.7-dev python3-pip -y
RUN apt install libsm6 libxext6 libxrender-dev libgl1-mesa-glx -y

RUN python3.7 -m pip install --upgrade pip

COPY ./codes/requirements.txt /requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip python3.7 -m pip install -r /requirements.txt --user
