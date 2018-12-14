ADD JAR s3://lrivkin-emr/json-serde-1.3.8-jar-with-dependencies.jar;

ADD FILE s3://lrivkin-emr/amazonstopwords.py;
ADD FILE s3://lrivkin-emr/english_stop.txt;

-- select only columns of interest
-- remove all punctuation (except internal ' like in don't) from review text
CREATE TABLE movies_tv_raw ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS 
SELECT reviewerid, overall, REGEXP_REPLACE(reviewtext, '[^0-9A-Za-z\' ]+', '') 
AS reviewtext FROM movies_tv_in;

-- remove stopwords
CREATE TABLE amazon_preprocessed_reviews 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' 
AS SELECT TRANSFORM(
	reviewerid, 
	overall, 
	LOWER(reviewtext)) 
USING 'amazonstopwords.py' AS (
	reviewerID STRING, 
	overall STRING, 
	reviewText STRING) 
FROM movies_tv_raw;
