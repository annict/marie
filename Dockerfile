FROM ruby:2.6.0-alpine

LABEL maintainer="https://annict.com/@shimbaco" \
      description="A quasi-organic master control program for Annict."

RUN apk update && \
    apk add -t build-dependencies \
        build-base

# Set to run `ls` in Pry
# https://github.com/pry/pry/issues/1494#issuecomment-162336567
ENV PAGER=busybox\ less

WORKDIR /marie/

COPY Gemfile Gemfile.lock /marie/
RUN bundle install -j$(getconf _NPROCESSORS_ONLN)

COPY . /marie/
