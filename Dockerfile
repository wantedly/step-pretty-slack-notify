FROM debian:jessie
MAINTAINER Seigo Uchida <spesnova@gmail.com> (@spesnova)

# Install ruby 2.1.5
RUN apt-get update && \
    apt-get install -y ruby && \
    rm -rf /var/lib/apt/lists/* && \
    gem install bundler --no-ri --no-rdoc

WORKDIR /app

COPY Gemfile      /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

CMD ["./run.sh"]
