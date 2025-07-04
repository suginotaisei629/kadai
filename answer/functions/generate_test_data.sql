CREATE OR REPLACE FUNCTION generate_test_data(start_date DATE, end_date DATE)
RETURNS VOID AS $$
DECLARE
  work_date DATE := start_date;
  new_order_id INTEGER;
BEGIN
  WHILE work_date <= end_date LOOP 
    INSERT INTO orders (order_datetime)
    VALUES (work_date + INTERVAL '12 hours')
    RETURNING order_id INTO new_order_id;

    INSERT INTO order_details (order_id, product_id, quantity)
    VALUES (
      new_order_id,
      floor(random() * 5)::int + 1, 
      floor(random() * 5)::int + 1
    );

    work_date := work_date + INTERVAL '1 day';
  END LOOP;
END;
$$ LANGUAGE plpgsql;