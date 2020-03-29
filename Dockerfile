FROM ubuntu:16.04

MAINTANER Vincent Lussenburg "vincent@lussenburg.net"

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

WORKDIR /my-app

COPY myapp/app.py /my-app/app.py

### This is the Alcide whitelist generator integration ###
ARG ALCIDE_PROCESS_WHITELIST_HASH_KEY
ENV ALCIDE_PROCESS_WHITELIST_HASH_KEY

RUN wget https://alcide.blob.core.windows.net/generic/whitelist-generator/generator &&\
    chmod +x generator &&\
    ./generator -k ${ALCIDE_PROCESS_WHITELIST_HASH_KEY} -f /my-app/app.py &&\
    rm -f generator
### End of integration section ###

ENTRYPOINT [ "python" ]

CMD [ "/my-app/app.py" ]
