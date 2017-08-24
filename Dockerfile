FROM ruby:2.4.1

RUN groupadd -r rhebok && useradd -r -g rhebok rhebok
RUN gem install sinatra sinatra-contrib rhebok
WORKDIR /app
COPY app /app

EXPOSE 8080
USER rhebok

CMD ["rackup", "-s", "Rhebok", "--host", "0.0.0.0", "--port", "8080", "config.ru"]
