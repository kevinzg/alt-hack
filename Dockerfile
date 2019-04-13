FROM debian:buster

RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        git \
        python3 \
        python3-pip

RUN alias pip=pip3 python=python3
RUN pip3 install pipenv

ENV HACK_PATH=/root/Hack
RUN git clone --branch dev --depth 1 https://github.com/source-foundry/Hack.git $HACK_PATH

WORKDIR $HACK_PATH
RUN ./build-pipenv.sh
RUN ./tools/scripts/install/ttfautohint-build.sh

# See https://github.com/source-foundry/Hack/issues/482#issuecomment-476325374
RUN find . -name '*.txt' -path "./postbuild_processing/tt-hinting/*" |\
        xargs sed '/zero/ s/^#*/# /' -i

WORKDIR /root/alt-hack
COPY ./glyphs ./glyphs
RUN touch ./patch-hack.sh
