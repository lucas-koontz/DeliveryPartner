#!/bin/sh

set -o errexit

printf "Running Puma..."
bundle exec puma -C config/puma.rb
