-- use import wizard to import csv

-- The Guy Who Didn't Like Musicals

SELECT SUBSTRING(id, 1, 26) AS id, text, like_count, author AS commentor, 
is_favorited, is_pinned, CASE WHEN parent != 'root' THEN 1 ELSE 0 END AS is_comment
INTO guy
FROM tgwdlm;

DELETE FROM guy
WHERE text = 'False';

SELECT *
FROM guy
WHERE is_favorited = 'True';
-- is_pinned, is_comment

WITH musicals AS (
    SELECT id, SUM(is_comment) AS comments
    FROM guy
    GROUP BY id
)

SELECT guy.id, guy.text, guy.like_count, guy.commentor, 
guy.is_favorited, guy.is_pinned, 
CASE WHEN guy.is_comment = 1 THEN 'True' ELSE 'False' END AS is_comment, 
ISNULL(musicals.comments, 0) AS comments, 'The Guy Who' AS musical
FROM musicals
RIGHT JOIN guy
ON musicals.id = guy.id;


-- Black Friday

SELECT SUBSTRING(id, 1, 26) AS id, text, like_count, author AS commentor, 
CASE WHEN is_favorited = 0 THEN 'False' ELSE 'True' END AS is_favorited, 
is_pinned, CASE WHEN parent != 'root' THEN 1 ELSE 0 END AS is_comment
INTO friday
FROM bf;

DELETE FROM friday
WHERE text = 'False';

SELECT *
FROM friday
WHERE is_favorited = 'True';

WITH black AS (
    SELECT id, SUM(is_comment) AS comments
    FROM friday
    GROUP BY id
)

SELECT friday.id, friday.text, friday.like_count, friday.commentor, 
friday.is_favorited, friday.is_pinned, 
CASE WHEN friday.is_comment = 1 THEN 'True' ELSE 'False' END AS is_comment, 
ISNULL(black.comments, 0) AS comments, 'Black Friday' AS musical
FROM black
RIGHT JOIN friday
ON black.id = friday.id;


-- Nerdy Prudes Must Die

SELECT SUBSTRING(id, 1, 26) AS id, text, like_count, author AS commentor, 
is_favorited, is_pinned, CASE WHEN parent != 'root' THEN 1 ELSE 0 END AS is_comment
INTO nerdy
FROM npmd;

SELECT *
FROM nerdy
WHERE is_favorited = 'True';

WITH prudes AS (
    SELECT id, SUM(is_comment) AS comments
    FROM nerdy
    GROUP BY id
)

SELECT nerdy.id, nerdy.text, nerdy.like_count, nerdy.commentor, 
nerdy.is_favorited, nerdy.is_pinned, 
CASE WHEN nerdy.is_comment = 1 THEN 'True' ELSE 'False' END AS is_comment, 
ISNULL(prudes.comments, 0) AS comments, 'Nerdy Prudes' AS musical
FROM prudes
RIGHT JOIN nerdy
ON prudes.id = nerdy.id;

-- save resulting tables as csv