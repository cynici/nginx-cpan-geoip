FROM nginx:alpine
LABEL maintainer "Cheewai Lai <clai@csir.co.za>"

ARG SUEXEC_VER=0.2

# Perl MakeMaker's prompt function, e.g. cpan, etc. will always return the default without waiting for user input.
ARG PERL_MM_USE_DEFAULT=1

# https://hub.docker.com/r/avastsoftware/alpine-perl-extended/
RUN apk update \
 && apk add gcc g++ make perl perl-dev curl wget bash \
 && cpan App::cpanminus \
 && rm -rf /root/.cpan \
 && cpanm install Geo::IP \
 && rm -rf /root/.cpanm \
 && curl -k -fsSL -o /tmp/suexec.tgz "https://github.com/ncopa/su-exec/archive/v${SUEXEC_VER}.tar.gz" \
 && cd /tmp \
 && tar xvf suexec.tgz \
 && cd "/tmp/su-exec-${SUEXEC_VER}" \
 && make \
 && cp -af su-exec /usr/bin/ \
 && apk del gcc g++ make perl-dev \
 && rm -rf /var/cache/apk/*

ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD geoipupdate.sh /geoipupdate.sh
