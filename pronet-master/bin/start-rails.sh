#!/bin/sh

set -e
cd /pronet

# Cleanup pid if it exists
if [ -f /pronet/tmp/pids/server.pid ]; then
  rm /pronet/tmp/pids/server.pid
fi

bundle exec rails s -p 3000 -b '0.0.0.0' # puma -C config/puma.rb