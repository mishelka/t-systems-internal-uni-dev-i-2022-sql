DROP TABLE IF EXISTS person, customer, color, contacts CASCADE;

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

ALTER TABLE person RENAME TO customer;
ALTER TABLE customer RENAME COLUMN id TO customer_id;

CREATE TABLE contacts (
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id)
	  REFERENCES customer(customer_id)
);
