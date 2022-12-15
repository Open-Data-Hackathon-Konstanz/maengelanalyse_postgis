CREATE TABLE IF NOT EXISTS {{table_name}} (
  id INT PRIMARY KEY NOT NULL,
  description VARCHAR(3000),
  category VARCHAR(500),
  address VARCHAR(500),
  group_ VARCHAR(500),
  lon FLOAT,
  lat FLOAT,
  year INT,
  month INT,
  reported DATE,
  approved DATE,
  checked DATE,
  approved_in FLOAT,
  district VARCHAR(500)
);

CREATE ROLE readaccess;

GRANT CONNECT ON DATABASE {{db_name}} TO readaccess;
GRANT USAGE ON SCHEMA public TO readaccess;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readaccess;
GRANT readaccess TO {{db_user}};

COPY {{table_name}}(id, description, category, address, group_, lon, lat, year, month, reported, approved, checked, checkedin, district)
FROM '/data/maengel.csv'
DELIMITER ','
CSV HEADER;