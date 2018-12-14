ADD FILE amazon_filterwords.py;
ADD FILE weighted_words.txt;

CREATE TABLE amazon_review_scores ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(reviewerid, overall, reviewtext) USING 'amazon_filterwords.py' AS (reviewerID STRING, overall STRING, score STRING) FROM amazon_preprocessed_reviews;
