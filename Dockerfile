FROM ruby:3.0.2
ENV RAILS_VERSION 6.1.4
WORKDIR /app

RUN bundle init \
    && sed -i -r "s/^# gem \"rails\"/gem \"rails\", '${RAILS_VERSION}' /" Gemfile \
    && bundle install

RUN apt-get update && apt-get install -y --no-install-recommends curl ;\
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - ;\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - ;\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list ;\
    apt-get update && apt-get install -y --no-install-recommends nodejs yarn ;\
    apt-get clean; rm -rf /var/lib/apt/lists/*

RUN bundle exec rails new .
# RUN bundle exec rails new . \
#                             --minimal \
#                             --skip-test

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]