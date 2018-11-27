SELECT DISTINCT message
    FROM ratings
    WHERE prod_id = 1274673
        AND message LIKE '%red%';