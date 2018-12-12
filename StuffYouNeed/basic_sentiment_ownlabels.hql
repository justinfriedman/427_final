ADD FILE filter_words_ownlabels.py;
ADD FILE weighted_words.txt;

CREATE TABLE review_scores_ownlabels ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(semester, hw_id, hw_number, label, new_review) USING 'filter_words_ownlabels.py' AS (semester STRING, hw_id STRING, hw_number INT, classification STRING, score STRING) FROM preprocessed_reviews;
