-- ============================================================
-- Amazon Sales Dataset - Data Cleaning 
-- Tool: MySQL Workbench
-- Dataset: Amazon Products & Reviews (Kaggle)
-- Author: Hajar Ezzy
-- GitHub: HajarEzzy
-- ============================================================

/*CREATE RAW TABLE & IMPORT DATA*/
CREATE TABLE amazon (
    product_id VARCHAR(20),
    product_name TEXT,
    category TEXT,
    discounted_price VARCHAR(20),
    actual_price VARCHAR(20),
    discount VARCHAR(10),
    rating VARCHAR(10),
    rating_count VARCHAR(20),
    about_product TEXT,
    user_id TEXT,
    user_name TEXT,
    review_id TEXT,
    review_title TEXT,
    review_content TEXT,
    img_link TEXT,
    product_link TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/amazon.csv'
INTO TABLE amazon
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


/* CREATE WORKING COPY*/
create table amazon_cleaned like amazon ;
insert into amazon_cleaned select* from amazon;

/*DROP IRRELEVANT COLUMNS*/
alter table amazon_cleaned 
drop column about_product,
drop column user_id,
drop column user_name,
drop column review_id,
drop column review_title,
drop column review_content,
drop column img_link,
drop column product_link;

/* REMOVE SYMBOLS*/
UPDATE amazon_cleaned
SET discounted_price = REPLACE(REPLACE(REPLACE(discounted_price, '₹', ''), '.', ''), ' ', ''),
    actual_price = REPLACE(REPLACE(REPLACE(actual_price, '₹', ''), '.', ''), ' ', ''),
    discount = REPLACE(REPLACE(discount, '%', ''), ' ', ''),
    rating_count = REPLACE(rating_count, ' ', '');
    
/*ADD HELPER COLUMNS*/
alter table amazon_cleaned 
add column product_name_short varchar (100) ,
add column main_category varchar(100);

update amazon_cleaned 
set product_name_short = trim(substring_index(product_name, ' ' , 7)),
	main_category= trim(substring_index(category, '|' , 1));

   /*CONVERT COLUMNS TO CORRECT DATA TYPES*/
   ALTER TABLE amazon_cleaned
MODIFY discounted_price DECIMAL(10,2),
MODIFY actual_price DECIMAL(10,2),
MODIFY discount INT,
MODIFY rating DECIMAL(2,1),
MODIFY rating_count INT;
 
/* FIX REMAINING FORMATTING ISSUES*/ 
update amazon_cleaned 
set discounted_price= replace( discounted_price, ',' , ''),
 actual_price= replace(actual_price, ',' , '');
 
 select rating_count, hex(rating_count), length(rating_count)
 from amazon_cleaned
where rating_count regexp '[^0-9]'
or length (rating_count)!= length(trim(rating_count));
 
 update amazon_cleaned
 set rating_count= replace(rating_count,',','');
 
 select rating_count ,rating
 from amazon_cleaned
 where rating regexp '[^0-9.]'
 or rating_count regexp '[^0-9]'
 or rating=''
 or rating_count = '';
 
 update amazon_cleaned set rating_count= null 
 where rating_count is null or rating_count='' or rating_count= ' ' 
 or trim(rating_count)= '';
 
 update amazon_cleaned set rating=null 
 where rating = '|';
 
 update amazon_cleaned set rating_count= null 
 where rating_count= 'null';
 
/* CHECK DUPLICATE PRODUCTS BY SHORT NAME*/
 select product_name_short, count(*) as cnt , 
 group_concat(product_id) from  amazon_cleaned
group by product_name_short
having cnt>1 order by 2 desc
limit 10;

/* REMOVE DUPLICATE PRODUCTS*/
 DELETE FROM amazon_cleaned
WHERE product_id IN (
    SELECT product_id FROM (
        SELECT product_id,
               ROW_NUMBER() OVER (PARTITION BY product_name_short ORDER BY product_id) as rn
        FROM amazon_cleaned
    ) t
    WHERE rn > 1
);

-- Check for any special characters in product names
SELECT product_name
FROM amazon_final
WHERE product_name REGEXP '[^[:print:]]'
OR product_name LIKE '%Â%'
OR product_name LIKE '%®%'
OR product_name LIKE '%™%';

 /* CREATE FINAL CLEAN TABLE*/
 create table amazon_final as 
 select 
	product_id ,
    min(product_name_short) as product_name,
    min(main_category) as category,
    min(discounted_price) as discounted_price,
    min(actual_price) as actual_price,
    min(discount) as discount,
    max(rating) as rating,
    min(rating_count) as rating_count
from amazon_cleaned
group by product_id;




