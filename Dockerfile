# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.1.2
FROM ruby:$RUBY_VERSION-slim

WORKDIR /rails

# Install packages for development
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    nodejs \
    yarn \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Environment setup
ENV BUNDLE_PATH="/bundle"
ENV BUNDLE_WITHOUT=""

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy source code
COPY . .

# Open ports for Rails + JS bundler (e.g., esbuild or Webpacker)
EXPOSE 3000 3035

# Default command
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]


