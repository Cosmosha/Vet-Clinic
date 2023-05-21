/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(200),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC(5,2),
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

CREATE TABLE owners(
 id INT GENERATED ALWAYS AS IDENTITY,
 full_name VARCHAR(200),
 age INT,
 PRIMARY KEY(id)
);

CREATE TABLE species(
 id INT GENERATED ALWAYS AS IDENTITY,
 name VARCHAR(100),
 PRIMARY KEY(id)
);

-- Make sure that id is set as autoincremented PRIMARY KEY
ALTER animals ADD PRIMARY KEY(id);

-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_species_id
FOREIGN KEY (species_id)
REFERENCES species(id);


ALTER TABLE animals
ADD COLUMN owners_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_owners_id
FOREIGN KEY (owners_id)
REFERENCES owners(id);