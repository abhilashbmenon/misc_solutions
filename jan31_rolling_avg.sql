select
    *
from
    (
        select
            transaction_date,
            avg(transaction_amount) over (
                ORDER BY
                    transaction_date ROWS BETWEEN 2 PRECEDING
                    AND CURRENT ROW
            ) AS rolling_3_day_average
        from
            (
                select
                    to_char(DATE(transaction_time), 'yyyy-mm-dd') transaction_date,
                    sum(transaction_amount) transaction_amount
                from
                    transactions
                group by
                    transaction_date
            ) date_sum
    ) date_window
where
    transaction_date = '2021-01-31';
