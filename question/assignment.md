# SQLバッチ処理 課題

## 概要

Eコマースサイトの売上データを想定したバッチ処理を作成し、SQLおよびシェルスクリプトのスキルを向上させることを目的とします。

## 背景

あなたはEコマースサイトのデータエンジニアです。日々の売上データを集計し、分析用のサマリーレポートをCSVファイルとして出力するバッチ処理を開発するよう依頼されました。

## システム要件

-   **データベース**: PostgreSQL
-   **実行環境**: Docker
-   **起動方法**: シェルスクリプト

## 課題内容

以下の要件を満たすバッチ処理システムを`answer`ディレクトリ内に構築してください。

### 1. テストデータ生成

-   指定された期間（開始日と終了日）の注文および注文明細のテストデータを生成するPL/pgSQL関数を作成してください。
-   この関数を呼び出すシェルスクリプトを作成してください。
-   シェルスクリプトは、`./generate_test_data.sh <start_date> <end_date>` のように、開始日と終了日を引数として受け取れるようにしてください。
    -   例: `./generate_test_data.sh 2025-07-01 2025-07-10`

### 2. 日次売上集計バッチ

-   `orders`テーブルと`order_details`テーブルから日次・商品別の売上サマリーを作成し、`daily_sales_summary`テーブルに格納するPL/pgSQL関数を作成してください。
-   この関数は、処理対象の日付を引数として受け取れるようにしてください。
-   `daily_sales_summary`テーブルの内容をCSVファイルとしてエクスポートする処理を実装してください。
-   上記の一連の処理（集計〜CSV出力）を実行するシェルスクリプト `run_batch.sh` を作成してください。
    -   スクリプトは `./run_batch.sh <target_date>` のように、集計対象日を引数として受け取れるようにしてください。
    -   例: `./run_batch.sh 2025-07-01`

### 3. 提出物

`answer`ディレクトリに、以下のファイルを含めてください。

1.  `docker-compose.yml`: PostgreSQLコンテナを起動するための設定ファイル。
2.  `init/`: Dockerコンテナ初回起動時に実行されるSQLファイルを格納するディレクトリ。
    -   `init/01_schema.sql`: テーブル（`products`, `orders`, `order_details`, `daily_sales_summary`）を作成するSQL。
    -   `init/02_master_data.sql`: `products`テーブルにいくつかのマスタデータを投入するSQL。
3.  `functions/`: 作成したPL/pgSQL関数を格納するディレクトリ。
    -   `functions/generate_test_data.sql`: テストデータを生成する関数。
    -   `functions/summarize_daily_sales.sql`: 日次売上を集計する関数。
4.  `generate_test_data.sh`: テストデータ生成を実行するシェルスクリプト。
5.  `run_batch.sh`: 日次売上集計バッチを実行するシェルスクリプト。
