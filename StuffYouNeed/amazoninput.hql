
CREATE TABLE music_small (
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

LOAD DATA LOCAL INPATH 'tiny_reviews.json' INTO TABLE music_small;

