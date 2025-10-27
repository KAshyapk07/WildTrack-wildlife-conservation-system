use wildlife_conservation;

DELIMITER //
CREATE TRIGGER UpdatePopulationAfterRescue
AFTER INSERT ON RescueOperation
FOR EACH ROW
BEGIN
    UPDATE Species
    SET Population = Population + 1
    WHERE SpeciesID = NEW.SpeciesID;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER UpdateLastCheckup
AFTER INSERT ON MedicalRecord
FOR EACH ROW
BEGIN
    UPDATE Species
    SET EndangeredStatus = 
        CASE
            WHEN NEW.HealthStatus = 'Critical' THEN 'Endangered'
            WHEN NEW.HealthStatus = 'Recovered' THEN 'Safe'
            ELSE EndangeredStatus
        END
    WHERE SpeciesID = NEW.SpeciesID;
END //
DELIMITER ;

-- procedure
DELIMITER //
CREATE PROCEDURE AddConservationProgram (
    IN p_Name VARCHAR(100),
    IN p_Type VARCHAR(50),
    IN p_Budget DECIMAL(12,2),
    IN p_Start DATE,
    IN p_End DATE,
    IN p_SpeciesID INT
)
BEGIN
    INSERT INTO ConservationProgram (Name, Type, Budget, StartDate, EndDate, SpeciesID)
    VALUES (p_Name, p_Type, p_Budget, p_Start, p_End, p_SpeciesID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetSpeciesByHabitat(IN hID INT)
BEGIN
    SELECT s.Name, s.Category, s.EndangeredStatus
    FROM Species s
    JOIN LivesIn l ON s.SpeciesID = l.SpeciesID
    WHERE l.HabitatID = hID;
END //
DELIMITER ;

-- function

DELIMITER //
CREATE FUNCTION TotalSponsorship(p_ProgramID INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(12,2);
    SELECT SUM(Contribution) INTO total
    FROM Sponsorship
    WHERE ProgramID = p_ProgramID;
    RETURN IFNULL(total, 0);
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION SpeciesCountByCategory(cat VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Species WHERE Category = cat;
    RETURN cnt;
END //
DELIMITER ;
