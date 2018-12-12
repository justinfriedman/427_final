ADD FILE filter_words.py;
ADD FILE weighted_words.txt;

CREATE TABLE review_scores ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(semester, hw_id, hw_number, label, LOWER(new_review)) USING 'filter_words.py' AS (semester STRING, hw_id STRING, hw_number INT, label STRING, score STRING, match STRING) FROM preprocessed_reviews;
