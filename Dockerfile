FROM ruby:3.1.3

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y nodejs && \
    apt-get install -y postgresql-client && \
    gem install rails -v '7.0.8.1'

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]