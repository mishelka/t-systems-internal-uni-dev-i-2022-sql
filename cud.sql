DROP TABLE IF EXISTS links;

CREATE TABLE links (
   id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
   url VARCHAR(250) NOT NULL,
   name VARCHAR(50) NOT NULL,
   last_update TIMESTAMP DEFAULT now() --current_timestamp
);

INSERT INTO
    links (url, name)
VALUES
    ('https://www.google.com','Google'),
    ('https://www.yahoo.com','Yahoo'),
    ('https://www.bing.com','Bing');

INSERT INTO links
VALUES(DEFAULT, 'http://kpi.fei.tuke.sk', 'KPI homepage', '2022-06-01') RETURNING id;

UPDATE links
SET last_update = '2020-08-01',
    name = 'Bing page'
WHERE id = 3;

DELETE FROM links
WHERE id = 1;

SELECT * FROM links;
