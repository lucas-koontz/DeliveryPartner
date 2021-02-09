FROM ruby:2.7.2-alpine


ARG PACKAGES="build-base libxslt-dev g++ gcc libxml2-dev make curl jq postgresql-dev tzdata git geos geos-dev"
ARG PORT=3000
ARG WORKDIR=/app


ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

WORKDIR $WORKDIR

COPY Gemfile .
COPY Gemfile.lock .

RUN gem install bundler:2.2.8 && \
    apk update && \
    apk add --no-cache ${PACKAGES} && \
    bundle install --jobs $(nproc) && \
    rm -r /var/cache/apk/*

COPY . .

EXPOSE $PORT

ENTRYPOINT ["./scripts/entrypoint.sh"]

CMD ["./scripts/server.sh"]
