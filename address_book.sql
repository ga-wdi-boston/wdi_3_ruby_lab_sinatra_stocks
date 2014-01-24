DROP TABLE IF EXISTS people;

CREATE TABLE people (
  id SERIAL PRIMARY KEY,
  name TEXT,
  phone TEXT
);

INSERT INTO people (name, phone)
  VALUES ('Jordan', '231-232-2131');

