use wildlife_conservation;
-- test the population updation trigger
INSERT INTO RescueOperation (OperationID, SpeciesID, StaffID, Date, Outcome)
VALUES (12, 1, 1, '2025-10-24', 'Tiger rescued and released');

SELECT SpeciesID, Name, Population FROM Species WHERE SpeciesID = 1;

-- test the last checkup
INSERT INTO MedicalRecord (RecordID, SpeciesID, HealthStatus, LastCheckupDate, TreatmentDetails)
VALUES (12, 1, 'Recovered', '2025-10-24', 'treatment Done');

SELECT SpeciesID, EndangeredStatus FROM Species WHERE SpeciesID = 1;


-- test the stored procedure
INSERT INTO Species (SpeciesID, Name, Category, EndangeredStatus, Population)
VALUES (11, 'Panda', 'Mammal', 'Endangered', 30);

CALL AddConservationProgram(
    'panda saving',
    'Wildlife Protection',
    1000000,
    '2025-10-22',
    '2027-09-17',
    11
);

SELECT * FROM ConservationProgram;

-- procedure which checks species in a habitat
CALL GetSpeciesByHabitat(3);

-- functions
-- total sponsership
SELECT TotalSponsorship(6) AS Total_Contribution;

-- species count by category
SELECT SpeciesCountByCategory('Mammal') AS Mammal_Count;

