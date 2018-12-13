ADD JAR json-serde-1.3.8-jar-with-dependencies.jar;

ADD FILE amazonstopwords.py;
ADD FILE english_stop.txt;

CREATE TABLE music_mycols ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT reviewerid, overall, REGEXP_REPLACE(reviewtext, '[^0-9A-Za-z\' ]+', '') AS reviewtext FROM music_small;

CREATE TABLE amazon_preprocessed_reviews ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' AS SELECT TRANSFORM(reviewerid, overall, LOWER(reviewtext)) USING 'amazonstopwords.py' AS (reviewerID STRING, overall STRING, reviewText STRING) FROM music_mycols;

DROP table music_mycols;


