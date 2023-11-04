FROM alpine:latest

WORKDIR /workspace

RUN apk update \
    && apk add python3 py-pip

RUN pip install poetry

RUN poetry new app

WORKDIR /workspace/app

COPY bin .

RUN ./requirements.sh

RUN python3 /workspace/app/main.py

CMD ""