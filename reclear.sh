mysql --user='root' --password='password' --execute='DROP DATABASE IF EXISTS sgp;CREATE DATABASE sgp;'
mysql --user='root' --password='password' sgp < sgp_ddl.sql && mysql --user='root' --password='password' sgp < sgp_insert.sql