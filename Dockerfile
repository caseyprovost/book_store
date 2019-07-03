FROM ruby:2.6.2-alpine as builder

# Set local timezone
RUN apk add --update tzdata && \
    cp /usr/share/zoneinfo/America/Detroit /etc/localtime && \
    echo "America/Detroit" > /etc/timezone

# Install your app's runtime dependencies in the container
RUN apk add --update --virtual runtime-deps postgresql-client nodejs libffi-dev readline sqlite

# Bundle into the temp directory
WORKDIR /tmp
ADD Gemfile* ./

RUN gem update --system
RUN gem install bundler && gem update bundler

RUN apk add --virtual build-deps build-base postgresql-dev libc-dev linux-headers libxml2-dev libxslt-dev readline-dev && \
    bundle install --jobs=2 && \
    apk del build-deps

# Copy the app's code into the container
ENV APP_HOME /app
COPY . $APP_HOME
WORKDIR $APP_HOME

# Configure development environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production

# Expose port 3000 from the container
EXPOSE 80
EXPOSE 443

# Run puma server by default
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
