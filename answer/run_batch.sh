#!/bin/bash

TARGET_DATE=$1

psql -U postgres -d practice_db -c "SELECT summarize_daily_sales('$TARGET_DATE');"

psql -U postgres -d practice_db -c "\copy (SELECT * FROM daily_sales_summary WHERE summary_date = '$TARGET_DATE') TO './daily_sales_summary_$TARGET_DATE.csv' CSV HEADER"

echo "日次売上集計とCSV出力が完了しました: daily_sales_summary_$TARGET_DATE.csv"
