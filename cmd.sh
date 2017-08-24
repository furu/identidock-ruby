#!/bin/bash

set -e

readonly HOST=0.0.0.0
readonly PORT=8080

if [ "$ENV" = 'DEV' ]; then
  echo "Running Development Server"
  exec ruby identidock.rb -o $HOST -p $PORT
else
  echo "Running Production Server"
  exec rackup -s Rhebok --host $HOST --port $PORT -E production config.ru
fi
