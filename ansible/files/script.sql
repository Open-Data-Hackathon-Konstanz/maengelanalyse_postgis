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

GRANT ALL ON schema public TO {{db_user}};

COPY {{table_name}}(id, description, category, address, group_, lon, lat, year, month, reported, approved, checked, approved_in, district)
FROM '/data/maengel.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE maengel
  ADD COLUMN point
    geometry(Point,4326);
  
UPDATE maengel SET point = ST_SetSRID(ST_MakePoint(lon, lat),4326);


