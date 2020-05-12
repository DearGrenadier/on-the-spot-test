FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y build-essential libmariadb-dev-compat libmariadb-dev

ENV APP_HOME /api
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN gem install bundler:2.1.4
RUN bundle install