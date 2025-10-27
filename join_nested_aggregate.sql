-- join
-- show species and animal saved
SELECT 
    cp.ProgramID,
    cp.Name AS ProgramName,
    s.Name AS SpeciesName,
    s.EndangeredStatus,
    cp.Budget
FROM ConservationProgram cp
JOIN Species s ON cp.SpeciesID = s.SpeciesID;

-- staff assigned to each habitat
SELECT 
    st.StaffID,
    st.Name AS StaffName,
    h.Name AS HabitatName,
    h.Location
FROM Staff st
JOIN Habitat h ON st.AssignedHabitatID = h.HabitatID;

-- sponsership and the program it funds

SELECT 
    sp.Name AS SponsorName,
    sp.Type AS SponsorType,
    cp.Name AS ProgramName,
    cp.Budget,
    sp.Contribution
FROM Sponsorship sp
JOIN ConservationProgram cp ON sp.ProgramID = cp.ProgramID;

-- Nested Queries
-- species involved in high budget program
SELECT Name 
FROM Species
WHERE SpeciesID IN (
    SELECT SpeciesID
    FROM ConservationProgram
    WHERE Budget > 1000000
);

-- researchers finding species which are endangered

SELECT Name
FROM Researcher
WHERE ResearchID IN (
    SELECT ResearchID
    FROM Studies
    WHERE SpeciesID IN (
        SELECT SpeciesID
        FROM Species
        WHERE EndangeredStatus = 'Endangered'
    )
);

-- Aggregate queries

-- avg budget of all programs
SELECT AVG(Budget) AS AverageBudget
FROM ConservationProgram;

-- most recently checked up species
SELECT s.Name, MAX(m.LastCheckupDate) AS LatestCheckup
FROM Species s
JOIN MedicalRecord m ON s.SpeciesID = m.SpeciesID
GROUP BY s.SpeciesID, s.Name;



