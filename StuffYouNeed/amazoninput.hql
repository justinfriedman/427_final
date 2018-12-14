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
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://lrivkin-emr/data/reviews_Movies_and_TV_5.json';

