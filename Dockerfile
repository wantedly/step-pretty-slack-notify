FROM quay.io/wantedly/ruby:2.2.0
MAINTAINER Seigo Uchida <spesnova@gmail.com> (@spesnova)

WORKDIR /app

COPY Gemfile      /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

CMD ["./run.sh"]
