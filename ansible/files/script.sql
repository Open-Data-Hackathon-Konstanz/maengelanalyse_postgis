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

COPY {{table_name}}(id, description, category, address, group_, lon, lat, year, month, reported, approved, checked, approved_in, district)
FROM '/data/maengel.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE maengel
  ADD COLUMN point
    geometry(Geometry,3857);



You can create an unconstrained SRID geometry column to hold the native form and then transform to existing. Here is a contrived example assuming you have polygons that you are copying from a staging table (if you have mixed, you can set type to geometry e.g geometry(Geometry,3857):

CREATE TABLE poi(gid serial primary key, 
   geom_native geometry(POLYGON),  
   geom_mercator geometry(POLYGON,3857) );

INSERT INTO TABLE poi(geom_native, geom_mercator)
SELECT geom, ST_Transform(geom, 3857)
   FROM staging.imported_poly;

