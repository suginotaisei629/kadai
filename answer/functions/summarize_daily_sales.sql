CREATE OR REPLACE FUNCTION summarize_daily_sales(target_date DATE)
RETURNS VOID AS $$
BEGIN

  DELETE FROM daily_sales_summary
  WHERE summary_date = target_date;

  INSERT INTO daily_sales_summary (
    summary_date,
    product_id,
    total_quantity_sold,
    total_sales_amount
  )
  SELECT
    target_date AS summary_date,
    od.product_id,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_sales_amount
  FROM
    orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
  WHERE
    DATE(o.order_datetime) = target_date
  GROUP BY
    od.product_id;
END;
$$ LANGUAGE plpgsql;