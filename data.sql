/* Populate database with sample data. */


INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon','2020-03-03','0',TRUE, 10.23); 
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon','2018-11-15','2',TRUE, 8); 
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu','2021-01-07','1',FALSE, 15.04); 
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon','2017-05-12','5',TRUE, 11); 

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Charmander','2020-02-08','0',FALSE, -11),('Plantmon','2021-11-15', '2','TRUE', -5.7),('Squirtle', '1993-05-02','3',FALSE,-12.13),('Angemon','2005-06-12','1',TRUE,-45),('Boarmon','2005-06-7','7',TRUE,20.4),('Blossom','1998-10-13','3',TRUE,17),('Ditto','2022-05-14','4',TRUE,22);

INSERT INTO owners (full_name, age) VALUES('Sam Smith',34),('Jennifer Orwel', 19),('Bob', 45),('Melody',77),('Dean Winchester', 14),('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('pokemon'),('digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon%';

UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals SET owners_id = 1 WHERE name = 'Agumon';

UPDATE animals SET owners_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals SET owners_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals SET owners_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals SET owners_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';