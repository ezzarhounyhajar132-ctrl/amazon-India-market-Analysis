-- ============================================================
-- Amazon Sales Dataset - exploratory data analysis
-- Tool: MySQL Workbench
-- Dataset: Amazon Products & Reviews (Kaggle)
-- Author: Hajar Ezzy
-- GitHub: HajarEzzy
-- ============================================================

/* top 5 category*/
select category, sum(discounted_price) as total_revenue 
from amazon_final
group by category 
order by total_price desc
limit 5 ;

/*top 10 products*/
select product_name, sum(discounted_price) as total_revenue 
from amazon_final
group by product_name 
order by total_price desc
limit 10;

/*Which product categories have the most products with no discount*/
select category,
 sum(case when discount= 0 then 1 else 0 end) as zero_discount,
round((sum(case when discount= 0 then 1 else 0 end)*100)/count(*),2) as percentage_zero_discount
from amazon_final
group by category;

/*highest rated product */
SELECT rating, product_name,category
FROM amazon_final
ORDER BY 1 desc
limit 10;

/*top 10 reviewed product */
SELECT  product_name, category ,rating_count
FROM amazon_final
ORDER BY 3 desc
limit 10;

/*avg discount by category*/
select category , round(avg( discount),1) as avg_discount
from amazon_final
group by category
order by 2 desc;

/*Does higher discount = higher rating*/
select 
case 
	when discount >= 70 then 'high(+70%)'
    when discount >=40 then 'medium(69-40%)'
    else 'low(39-0%)' 
end as discount_range ,
count(*) as total_products
, round(avg(rating),2) as avg_rating
from amazon_final
group by discount_range;
 
 /*Price range distribution*/
  select
  case
	 when actual_price <500 then 'budget(<500)'
     when actual_price < 2000 then 'mid(500-2000)'
     else 'premium(+2000)'
     end as price_range,
     count(*) as total_products,
     round(avg(rating),2) as avg_rating
  from amazon_final
  group by price_range;
  
  select *from amazon_final ;