{{ config(
    materialized = 'table',
    schema = 'marts',
    tags = ['time_spine']
)}}

-- Databricks 原生生成连续日期（2010-2030，无第三方依赖）
select
    date_day,
    date_trunc('week', date_day)   as date_week,
    date_trunc('month', date_day)  as date_month,
    date_trunc('quarter', date_day) as date_quarter,
    date_trunc('year', date_day)   as date_year
from (
    select
        explode(sequence(
            to_date('2010-01-01'),  -- 开始日期
            to_date('2030-12-31'),  -- 结束日期
            interval 1 day          -- 日粒度
        )) as date_day
)