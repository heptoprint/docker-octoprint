FROM python:2.7-alpine3.11 as build
RUN apk --no-cache add build-base linux-headers
RUN mkdir -p octoprint && \
    wget -qO- https://github.com/foosel/OctoPrint/archive/master.tar.gz | tar xz -C octoprint --strip-components 1 && \
    cd octoprint && \
    pip install -r requirements.txt && \
    python setup.py install

FROM python:2.7-alpine3.11
LABEL maintainer="squat <lserven@gmail.com>"
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /octoprint /opt/octoprint
RUN apk --no-cache add build-base ffmpeg libjpeg
RUN addgroup -S octoprint && adduser -S -G octoprint octoprint
USER octoprint
RUN mkdir -p ~/.octoprint
ENV PIP_USER true
ENV PYTHONUSERBASE /home/octoprint/.octoprint/plugins
RUN pip install https://github.com/tg44/OctoPrint-Prometheus-Exporter/archive/f1e603249761a88dd30b709ffaf46083ae38df98.zip
ENTRYPOINT ["/usr/local/bin/octoprint"]
CMD ["serve", "--host=0.0.0.0"]
