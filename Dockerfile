FROM ruby:2.5-slim

# The instructions are stolen from https://github.com/mtsmfm/docker-ruby-awscli
RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends unzip python-dev curl git && \
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
  unzip awscli-bundle.zip && \
  ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
  rm -rf ./awscli-bundle awscli-bundle.zip

COPY --from=yuyat/circle-gh-tee /usr/local/bin/circle-gh-tee /usr/local/bin
