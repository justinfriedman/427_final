SELECT EXPLODE(NGRAMS(SENTENCES(LOWER(message)), 3, 5))
    AS bigrams
    FROM ratings
    WHERE prod_id = 1274673;