#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <start_date> <end_date>"
  exit 1
fi

START_DATE=$1
END_DATE=$2
CONTAINER_NAME=sql-batch-practice-db

docker exec -i $CONTAINER_NAME psql -U postgres -d practice_db -c "SELECT generate_test_data('$START_DATE', '$END_DATE');"