/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon"
SELECT * from animals WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;

-- List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < '3';

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM  animals
  WHERE weight_kg >= 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE animals.neutered = 'true';

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE animals.name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE
  weight_kg BETWEEN 10.4 AND 17.3
  OR weight_kg = 10.4 AND weight_kg = 17.3;


-- DAY 2

-- update the animals table by setting the species column to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';

-- Verify that change was made.
SELECT * FROM animals;

-- Then roll back the change
ROLLBACK;

-- verify that the species columns went back to the state before the transaction
SELECT * FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE animals.name LIKE '%mon%';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Commit the transaction.
COMMIT;

-- Verify that changes persist after commit.
SELECT * FROM animals;

-- Inside a transaction delete all records in the animals table
BEGIN;
DELETE FROM animals;

-- then roll back the transaction.
ROLLBACK;

-- Verify that changes.
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE birth_date > DATE '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT day2_savepoint;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Update all animals' weight to be their weight multiplied by -1.
ROLLBACK TO SAVEPOINT day2_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
 UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

--  Commit transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) AS Total_Animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS Num_OF_Never_Escape FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT avg(weight_kg) AS Avergae_Weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_Weight, MAX(weight_kg) AS max_Weight FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS Averge_Escape from animals where EXTRACT(year FROM date_of_birth) between 1990 and 2000 GROUP BY species;


-- Day3
-- Make sure that id is set as autoincremented PRIMARY KEY
ALTER animals ADD PRIMARY KEY(id);

-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- What animals belong to Melody Pond?
select * from animals
Join owners on animals.owners_id = owners.id
Where owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals
JOIN species on animals.species_id = species.id
WHERE species.name = 'pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name As owners_Name, animals.name As Animals
From owners
LEFT JOIN animals ON owners.id = animals.owners_id;

-- How many animals are there per species?
SELECT species.name AS Species_Name, COUNT(animals.id) AS NUM_OF_Animals
FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT *
FROM owners
JOIN animals ON owners.id = animals.owners_id
where animals.species_id = 2 AND owners.full_name = 'Jennifer Orwel';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT *
FROM owners
JOIN animals ON owners.id = animals.owners_id
where animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT owners.full_name AS Owners, COUNT(animals.*) AS Num_of_Animals
FROM owners
JOIN animals ON owners.id = animals.owners_id
GROUP BY owners.full_name
ORDER BY Num_of_Animals DESC;

-- Day 4

-- Who was the last animal seen by William Tatcher?
SELECT an.name AS Animal_name
FROM animals AS an
JOIN visits AS vst ON an.id = vst.animal_id
JOIN vets AS v ON vst.vet_id = v.id
WHERE v.name = 'William Tatcher'
ORDER BY vst.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT vst.animal_id) As Numb_of_Animals_Seen
FROM visits AS vst
JOIN vets AS v ON vst.vet_id = v.id
WHERE v.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, sp.name As Specialty_Name
FROM vets AS v
JOIN specializations AS s ON v.id=s.vet_id
JOIN species AS sp ON s.species_id = sp.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT an.name AS Animal_Name
FROM animals AS an
JOIN visits AS vst ON an.id = vst.animal_id
JOIN vets AS v ON vst.vet_id = v.id
WHERE v.name = 'Stephanie Mendez' AND vst.visit_date >= '2020-04-01' AND vst.visit_date <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT an.name AS animal_name, count(*) AS number_of_visit
FROM animals AS an
JOIN visits AS vst ON an.id = vst.animal_id
Group By an.name
Order By number_of_visit DESC
limit 1;

-- Who was Maisy Smith's first visit?
SELECT an.name AS Animal_Name, vst.visit_date
FROM animals AS an
JOIN visits AS vst ON an.id = vst.animal_id
JOIN vets AS v ON vst.vet_id = v.id
WHERE v.name = 'Maisy Smith'
ORDER By vst.visit_date ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT an.name, an.date_of_birth, an.weight_kg, v.name AS vet_name, v.age AS vet_age, vst.visit_date
FROM animals AS an
JOIN visits AS vst ON an.id = vst.animal_id
JOIN vets AS v On vst.vet_id = v.id
ORDER By vst.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS numb_of_visit_not_specialize
FROM visits As vst
JOIN animals AS an ON vst.animal_id = an.id
JOIN vets AS v ON vst.vet_id = v.id
JOIN specializations AS sp ON an.species_id = sp.species_id AND v.id = sp.vet_id
Where sp.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name, count(*) As number_of_visits
FROM visits As vst
JOIN animals AS an ON vst.animal_id = an.id
JOIN vets As v ON vst.vet_id = v.id
JOIN specializations AS sp ON an.species_id = sp.species_id
JOIN species As s ON sp.species_id = s.id
WHERE v.name ='Maisy Smith'
GROUP By s.name
ORDER By number_of_visits DESC
LIMIT 1;