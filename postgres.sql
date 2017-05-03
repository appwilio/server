DROP DATABASE IF EXISTS forge;
CREATE DATABASE forge;
CREATE USER forge WITH password 'forge';
GRANT ALL privileges ON DATABASE forge TO forge;