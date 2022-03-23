#!/bin/bash

function commit() {
  msg "Committing changes"
  message="$1"
  git add .
  git commit -m "${message:-$(git rev-parse --abbrev-ref HEAD)}"
  git push origin $(git rev-parse --abbrev-ref HEAD)
}

function lint() {
  msg "Running Linter"
  rubocop -A
}

function run() {
  msg "Running Locally..."
  ruby challenges/challenge_1.rb
  ruby challenges/challenge_2.rb
  ruby challenges/challenge_3.rb
  ruby challenges/challenge_4.rb
  ruby challenges/challenge_5.rb
  ruby challenges/challenge_6.rb
  ruby challenges/challenge_7.rb
}

function test() {
  msg "Running Tests"
  ruby -Ilib -e 'ARGV.each { |f| require f }' ./tests/*.rb
}

function test_and_lint() {
  msg "Running Linter and Tests"
  lint
  test
}

function msg() {
  echo
  echo "*************************"
  echo $1
  echo "*************************"
  echo
}
