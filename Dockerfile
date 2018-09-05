FROM rust:1.28 AS rust

RUN git clone https://github.com/yuya-takeyama/circle-gh-tee && \
  cd circle-gh-tee && \
  cargo build --release

FROM ruby:2.5

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends unzip python-dev && \
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
  unzip awscli-bundle.zip && \
  ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
  rm -rf ./awscli-bundle awscli-bundle.zip

COPY --from=rust /circle-gh-tee/target/release/circle-gh-tee /usr/local/bin
