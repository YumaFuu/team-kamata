FROM ruby:2.7.3

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    ffmpeg \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

ADD Gemfile Gemfile

ADD Gemfile.lock Gemfile.lock

RUN echo 'gem: --no-document' > ~/.gemrc \
 && gem install bundler \
 && bundle install

ENV APP_HOME /app

WORKDIR $APP_HOME

ADD . $APP_HOME

EXPOSE 9000

CMD ["bundle", "exec", "rackup", "-p", "9000", "-o", "0.0.0.0"]
