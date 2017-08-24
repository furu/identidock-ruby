FROM ruby:2.4.1

RUN groupadd -r rhebok && useradd -r -g rhebok rhebok
RUN gem install sinatra sinatra-contrib rhebok
WORKDIR /app
COPY app /app
COPY cmd.sh /

EXPOSE 9292
USER rhebok

CMD ["/cmd.sh"]
