FROM ruby:3.2-slim
LABEL maintainer="efrj@hotmail.com"

# Minimal requirements to run a Rails app
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
    nodejs \
    npm \
    tzdata \
    imagemagick \
    libvips-dev \
    && npm install --global yarn \
    && rm -rf /var/lib/apt/lists/*

ENV APP_PATH /usr/src/app

# Different layer for gems installation
WORKDIR $APP_PATH
ADD Gemfile $APP_PATH
ADD Gemfile.lock $APP_PATH
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Copy the application into the container
COPY . $APP_PATH
EXPOSE 3000
