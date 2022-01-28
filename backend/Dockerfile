FROM ruby:2.7.3

RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg

WORKDIR /app

ADD Gemfile Gemfile

ADD Gemfile.lock Gemfile.lock

RUN gem install bundler \
 && bundle install

ADD . /app

EXPOSE 9000

CMD ["bundle", "exec", "rackup", "-p", "9000", "-o", "0.0.0.0"]
