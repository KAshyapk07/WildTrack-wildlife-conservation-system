create database Wildlife_Conservation;
Use Wildlife_Conservation;

CREATE TABLE Species (
    SpeciesID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    EndangeredStatus VARCHAR(50),
    Population INT
);
CREATE TABLE Habitat (
    HabitatID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Area DECIMAL(10,2),
    Climate VARCHAR(50),
    Type VARCHAR(50)
);
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    Contact VARCHAR(50),
    AssignedHabitatID INT,
    FOREIGN KEY (AssignedHabitatID) REFERENCES Habitat(HabitatID)
);
CREATE TABLE ConservationProgram (
    ProgramID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(50),
    Budget DECIMAL(12,2),
    StartDate DATE,
    EndDate DATE,
    SpeciesID INT,
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);
CREATE TABLE Researcher (
    ResearchID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Field VARCHAR(100),
    Affiliation VARCHAR(100),
    Contact VARCHAR(50)
);
CREATE TABLE Sponsorship (
    SponsorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(50),
    Contribution DECIMAL(12,2),
    ProgramID INT,
    FOREIGN KEY (ProgramID) REFERENCES ConservationProgram(ProgramID)
);
CREATE TABLE MedicalRecord (
    RecordID INT PRIMARY KEY,
    SpeciesID INT,
    HealthStatus VARCHAR(100),
    LastCheckupDate DATE,
    TreatmentDetails TEXT,
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);
CREATE TABLE Visitor (
    VisitorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    VisitDate DATE,
    Purpose VARCHAR(100)
);
CREATE TABLE MigrationRecord (
    MigrationID INT PRIMARY KEY,
    SpeciesID INT,
    Date DATE,
    FromHabitatID INT,
    ToHabitatID INT,
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    FOREIGN KEY (FromHabitatID) REFERENCES Habitat(HabitatID),
    FOREIGN KEY (ToHabitatID) REFERENCES Habitat(HabitatID)
);
CREATE TABLE AwarenessCampaign (
    CampaignID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    TargetAudience VARCHAR(100),
    Date DATE
);
CREATE TABLE LivesIn (
    SpeciesID INT,
    HabitatID INT,
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    FOREIGN KEY (HabitatID) REFERENCES Habitat(HabitatID)
);
CREATE TABLE ProtectedBy (
    SpeciesID INT,
    StaffID INT,
    PRIMARY KEY (SpeciesID, StaffID),
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE Studies (
    ResearchID INT,
    SpeciesID INT,
    PRIMARY KEY (ResearchID, SpeciesID),
    FOREIGN KEY (ResearchID) REFERENCES Researcher(ResearchID),
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);
CREATE TABLE Attends (
    VisitorID INT,
    CampaignID INT,
    PRIMARY KEY (VisitorID, CampaignID),
    FOREIGN KEY (VisitorID) REFERENCES Visitor(VisitorID),
    FOREIGN KEY (CampaignID) REFERENCES AwarenessCampaign(CampaignID)
);

CREATE TABLE RescueOperation (
    OperationID INT PRIMARY KEY,
    SpeciesID INT,
    StaffID INT,
    Date DATE,
    Outcome VARCHAR(100),
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);