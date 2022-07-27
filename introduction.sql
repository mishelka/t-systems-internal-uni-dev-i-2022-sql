DROP TABLE IF EXISTS person, color;

CREATE TABLE color (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR NOT NULL
);

-- nech je id v person auto generovana hodnota
CREATE TABLE person (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    identification_number UUID NOT NULL UNIQUE,
    age INT NOT NULL CHECK(age > 0),
    birth_date DATE,
    address VARCHAR(25),
    salary DECIMAL(18,2) DEFAULT 5000.00 CHECK(salary > 0)
);