CREATE TABLE hw_reviews (semester STRING, hw_id STRING, hw_number INT, label STRING, review STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
-- hadoop fs -put hw_reviews.txt /user/hive/warehouse/hw_reviews
