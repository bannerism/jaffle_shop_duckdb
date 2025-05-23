-- DuckDB has a built-in function to generate a series of dates, which is more reliable.
-- We'll generate dates for the year 2018 to match the Jaffle Shop data.

select cast(date_day as date) as date_day
from generate_series(
    cast('2018-01-01' as date),
    cast('2018-12-31' as date),
    interval 1 day
) as g(date_day)