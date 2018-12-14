ADD JAR s3://lrivkin-emr/json-serde-1.3.8-jar-with-dependencies.jar;

CREATE EXTERNAL TABLE movies_tv_in (
    reviewerID STRING,
	asin STRING,
	reviewerName STRING,
	helpful struct<helpful1:int, helpful2:int>,
	reviewText STRING,
	overall FLOAT,
	summary STRING,
	unixReviewTime INT,
	reviewTime STRING
	)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe';
LOAD DATA INPATH 's3://lrivkin-emr/data/reviews_Movies_and_TV_5.json' INTO TABLE movies_tv_in;

ADD FILE s3://lrivkin-emr/amazonstopwords.py;
ADD FILE s3://lrivkin-emr/english_stop.txt;

CREATE TABLE movies_tv_raw ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT reviewerid, overall, REGEXP_REPLACE(reviewtext, '[^0-9A-Za-z\' ]+', '') AS reviewtext FROM movies_tv_in;

CREATE TABLE amazon_preprocessed_reviews ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(reviewerid, overall, LOWER(reviewtext)) USING 'amazonstopwords.py' AS (reviewerID STRING, overall STRING, reviewText STRING) FROM movies_tv_raw;

ADD FILE s3://lrivkin-emr/amazon_filterwords.py;
ADD FILE s3://lrivkin-emr/weighted_words.txt;

CREATE TABLE amazon_review_scores ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(reviewerid, overall, reviewtext) USING 'amazon_filterwords.py' AS (reviewerID STRING, overall STRING, score STRING) FROM amazon_preprocessed_reviews;

INSERT OVERWRITE DIRECTORY 's3://lrivkin-emr/output' SELECT * FROM amazon_review_scores;
