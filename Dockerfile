FROM ubuntu:20.04 AS builder

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install tzdata

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y build-essential libopencv-dev python3 python3-pip

COPY dev-requirements.txt .

RUN pip3 install -r dev-requirements.txt

COPY . /build

WORKDIR /build

RUN python3 setup.py build bdist_wheel

RUN ls -al /build/dist/

FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install tzdata
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y ffmpeg

RUN apt-get update && \
    apt-get install -y python3 python3-pip

COPY --from=builder /build/dist/*.whl .

RUN pip3 install *.whl

# Install gosu
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

RUN useradd app

COPY src /app/src

WORKDIR /app

RUN mkdir PROCESSING_ZONE

RUN cd src/pymdb && python3 setup.py install

COPY docker-entrypoint.sh /app

RUN chown -R app:app /app

ENV PYTHONUNBUFFERED 1

ENTRYPOINT ["/app/docker-entrypoint.sh", "movinyl"]
