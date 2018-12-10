ADD FILE filer_words.py;
ADD FILE neg-words.txt;
ADD FILE pos-words.txt;

CREATE TABLE review_scores ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(hw_id, hw_number, label, LOWER(new_review)) USING 'filter_words.py' AS (hw_id STRING, hw_number INT, label STRING, score STRING) FROM preprocessed_reviews;