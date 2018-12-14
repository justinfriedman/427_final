ADD FILE s3://lrivkin-emr/amazon_filterwords.py;
ADD FILE s3://lrivkin-emr/weighted_words.txt;

-- calculate overall review score
CREATE TABLE amazon_review_scores ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS 
SELECT TRANSFORM(
	reviewerid, 
	overall, 
	reviewtext) 
USING 'amazon_filterwords.py' AS (
	reviewerID STRING, 
	overall STRING, 
	score STRING) 
FROM amazon_preprocessed_reviews;

-- output results
INSERT OVERWRITE DIRECTORY 's3://lrivkin-emr/output' 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM amazon_review_scores;
