## Connecting to the database
For example with psql on linux or mac:
```
export PGPASSWORD=<password>
psql -d main --username participant -h maengel.jstet.net
```
I will send you the password on request.

```
# Namen der Stadtteile:
Konstanz-Allmannsdorf
Konstanz-Petershausen-Ost
Konstanz-Staad
Konstanz-Industriegebiet
Konstanz-Königsbau
Konstanz-Fürstenberg
Konstanz-Petershausen-West
Konstanz-Altstadt
Konstanz-Paradies
Konstanz-Wollmatingen
Konstanz-Egg
Konstanz-Litzelstetten
Konstanz-Dingelsdorf
Konstanz-Wallhausen
Konstanz-Dettingen
# SQL-Queries:
# Spalte Stadtteile hinzufügen
ALTER TABLE maengel
ADD Stadtteil varchar(100);
# einen Stadtteil auswählen (hier: Konstanz-Staad)
WITH Stadtteile AS(SELECT *
FROM planet_osm_polygon 
WHERE name like '%Konstanz%' AND (admin_level ='10' OR admin_level = '9') AND name = 'Konstanz-Staad')
# prüfen, ob Mängel-Punkt in Stadtteil liegt (hier: Konstanz-Staad) & Stadtteil in Spalte hinzufügen
# wird auf alle Zeilen angewendet
UPDATE maengel 
SET Stadtteil = 'Konstanz-Staad'
WHERE maengel.id IN (select id
from maengel as a
join Stadtteile as b
on ST_WITHIN(a.point, b.way))
```