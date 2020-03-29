FROM ubuntu:xenial

LABEL maintainer="vincent@lussenburg.net"

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

WORKDIR /

COPY my-app/app.py /

RUN pip install Flask

### This is the Alcide whitelist generator integration ###
ARG ALCIDE_PROCESS_WHITELIST_HASH_KEY
ENV ALCIDE_PROCESS_WHITELIST_HASH_KEY ALCIDE_PROCESS_WHITELIST_HASH_KEY

ADD https://alcide.blob.core.windows.net/generic/whitelist-generator/generator /generator

RUN chmod +x /generator &&\
    /generator -k ${ALCIDE_PROCESS_WHITELIST_HASH_KEY} -i /app.py &&\
    rm -f generator
### End of integration section ###

ENTRYPOINT [ "python" ]

CMD [ "/app.py" ]
