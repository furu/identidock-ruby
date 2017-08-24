FROM ruby:2.4.1

RUN gem install sinatra
WORKDIR /app
COPY app /app

CMD ["ruby", "identidock.rb", "-o", "0.0.0.0"]
