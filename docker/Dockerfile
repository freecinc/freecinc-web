FROM ruby:2.6

RUN mkdir -p /app
WORKDIR /app
ADD app.tar /app/
RUN bundle install
EXPOSE 80
CMD bundle exec rackup config-freecinc.ru -p 80 -o 0.0.0.0
