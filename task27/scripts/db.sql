CREATE DATABASE otusdb;
CREATE USER 'userotus'@'%' IDENTIFIED BY 'otusdbpass';
GRANT ALL PRIVILEGES ON otusdb.* TO 'userotus'@'%';
