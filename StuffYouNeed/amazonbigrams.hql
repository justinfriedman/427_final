-- This script gets the top 100 bi-grams in order by frequency
-- It just groups the bigrams (no stopword filtering) and spits them out

ADD JAR json-serde-1.3.8-jar-with-dependencies.jar;

CREATE table amazon_struct ( NEW_ITEM ARRAY<STRUCT<ngram:array<string>, estfrequency:double>>);

-- note: replace music_small with the table you want bigrams for
INSERT OVERWRITE TABLE amazon_struct SELECT context_ngrams(sentences(lower(reviewtext)), array(null,null), 100) AS snippet from music_small;

CREATE TABLE amazon_bigrams (term1 STRING, term2 STRING, freq DOUBLE);

INSERT OVERWRITE TABLE amazon_bigrams select X.ngram[0],X.ngram[1],X.estfrequency  from (select explode(new_item) as X from amazon_struct) Z;
