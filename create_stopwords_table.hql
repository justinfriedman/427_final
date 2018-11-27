CREATE TABLE stopwords (word STRING) ROW FORMAT DELIMITED;
-- hadoop fs -put new_stop_list /user/hive/warehouse/stopwords