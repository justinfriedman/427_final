ADD FILE stopwords.py;
ADD FILE english_stop.txt;
CREATE TABLE preprocessed_reviews ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(semester, hw_id, hw_number, label, LOWER(review)) USING 'stopwords.py' AS (semester STRING, hw_id STRING, hw_number INT, label STRING, new_review STRING) FROM hw_reviews;