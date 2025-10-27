
use wildlife_conservation;
INSERT INTO Species (SpeciesID, Name, Category, EndangeredStatus, Population) VALUES
(1,'Bengal Tiger','Mammal','Endangered',120),
(2,'Asian Elephant','Mammal','Vulnerable',350),
(3,'Snow Leopard','Mammal','Endangered',80),
(4,'Indian Rhino','Mammal','Vulnerable',200),
(5,'Olive Ridley Turtle','Reptile','Vulnerable',500),
(6,'Ganges Dolphin','Mammal','Endangered',90),
(7,'Indian Peafowl','Bird','Least Concern',900),
(8,'Red Panda','Mammal','Endangered',60),
(9,'King Cobra','Reptile','Vulnerable',400),
(10,'Lion-tailed Macaque','Mammal','Endangered',120);

INSERT INTO Habitat (HabitatID, Name, Location, Area, Climate, Type) VALUES
(1,'Sundarbans Reserve','West Bengal',9600.50,'Tropical','Forest'),
(2,'Kaziranga Park','Assam',4300.75,'Humid','Grassland'),
(3,'Himalayan Reserve','Ladakh',12000.20,'Cold','Mountain'),
(4,'Chilika Lake','Odisha',1500.00,'Moderate','Wetland'),
(5,'Gir Forest','Gujarat',2200.00,'Dry','Forest'),
(6,'Corbett Park','Uttarakhand',1318.54,'Temperate','Forest'),
(7,'Periyar Sanctuary','Kerala',925.65,'Humid','Rainforest'),
(8,'Ranthambore','Rajasthan',1334.00,'Dry','Forest'),
(9,'Nagarhole','Karnataka',643.39,'Moderate','Forest'),
(10,'Keoladeo Park','Rajasthan',500.00,'Dry','Wetland');

INSERT INTO Staff (StaffID, Name, Role, Contact, AssignedHabitatID) VALUES
(1,'Arun Sharma','Ranger','9876543210',1),
(2,'Meena Das','Veterinarian','9123456789',2),
(3,'Ravi Kumar','Ecologist','9988776655',3),
(4,'Sneha Iyer','Guide','9876501234',4),
(5,'Ramesh Patil','Warden','9876000012',5),
(6,'Vivek Shetty','Forest Officer','9123012301',6),
(7,'Divya Rao','Zoologist','9234567890',7),
(8,'Kiran Singh','Tracker','9345678901',8),
(9,'Pooja Jain','Rescue Worker','9456789012',9),
(10,'Manish Thakur','Research Assistant','9567890123',10);

INSERT INTO ConservationProgram (ProgramID, Name, Type, Budget, StartDate, EndDate, SpeciesID) VALUES
(1,'Project Tiger','Protection',1200000,'2024-01-01','2026-12-31',1),
(2,'Save the Elephants','Research',900000,'2024-03-15','2026-03-14',2),
(3,'Snow Leopard Initiative','Tracking',800000,'2025-01-01','2026-12-31',3),
(4,'Rhino Care Mission','Medical',400000,'2025-04-01','2025-12-31',4),
(5,'Turtle Nest Watch','Awareness',350000,'2025-02-01','2025-12-31',5),
(6,'Ganga Dolphin Project','Research',500000,'2025-03-01','2026-02-28',6),
(7,'Peafowl Protection','Habitat Restoration',250000,'2024-08-01','2025-07-31',7),
(8,'Red Panda Revival','Breeding',600000,'2025-05-01','2026-05-01',8),
(9,'King Cobra Safety','Awareness',200000,'2025-06-01','2025-12-01',9),
(10,'Macaque Monitoring','Tracking',300000,'2024-09-01','2026-08-31',10);

INSERT INTO Researcher (ResearchID, Name, Field, Affiliation, Contact) VALUES
(1,'Dr. Kavya Menon','Zoology','PES University','9999998888'),
(2,'Dr. Arjun Rao','Ecology','IISc Bangalore','8888887777'),
(3,'Dr. Neha Patel','Marine Biology','NCBS','7777776666'),
(4,'Dr. Ankit Jain','Ornithology','BNHS','6666665555'),
(5,'Dr. Meera Shah','Wildlife Medicine','WII Dehradun','9999900000'),
(6,'Dr. Keshav Reddy','Mammalogy','IIT Bombay','9898989898'),
(7,'Dr. Leela Krishnan','Herpetology','ZSI India','9797979797'),
(8,'Dr. Ananya Roy','Conservation Biology','WWF India','9696969696'),
(9,'Dr. Rajesh Naik','Veterinary Science','IISER Pune','9595959595'),
(10,'Dr. Tanuja Bhat','Environmental Science','NIT Trichy','9494949494');

INSERT INTO Sponsorship (SponsorID, Name, Type, Contribution, ProgramID) VALUES
(1,'WWF India','NGO',500000,1),
(2,'Tata Trusts','Corporate',300000,2),
(3,'UNDP','International',200000,3),
(4,'Forest Dept. India','Government',400000,4),
(5,'Reliance Foundation','Corporate',250000,5),
(6,'Amazon Cares','Corporate',220000,6),
(7,'Google India','Corporate',310000,7),
(8,'IUCN','International',450000,8),
(9,'Save Earth Org','NGO',180000,9),
(10,'Infosys Foundation','Corporate',270000,10);

INSERT INTO MedicalRecord (RecordID, SpeciesID, HealthStatus, LastCheckupDate, TreatmentDetails) VALUES
(1,1,'Healthy','2025-08-10','Routine vaccination done'),
(2,2,'Injured','2025-09-01','Leg wound treatment ongoing'),
(3,3,'Stable','2025-07-25','Monitoring oxygen intake'),
(4,4,'Recovered','2025-06-20','Post-poaching recovery'),
(5,5,'Healthy','2025-08-15','Nesting inspection done'),
(6,6,'Critical','2025-09-10','Respiratory infection treatment'),
(7,7,'Healthy','2025-07-19','Regular check'),
(8,8,'Weak','2025-10-01','Low appetite; supplements given'),
(9,9,'Recovered','2025-08-29','Antivenom tests completed'),
(10,10,'Healthy','2025-09-18','Routine health check');

INSERT INTO Visitor (VisitorID, Name, VisitDate, Purpose) VALUES
(1,'Rohit Verma','2025-08-01','Education'),
(2,'Priya Nair','2025-08-10','Tourism'),
(3,'Ananya Singh','2025-09-05','Research'),
(4,'Amit Joshi','2025-09-15','Photography'),
(5,'Kiran Rao','2025-10-01','Awareness'),
(6,'Suresh Mehta','2025-07-20','Volunteer'),
(7,'Nidhi Patel','2025-09-22','Campaign'),
(8,'Aditya Rao','2025-10-05','Wildlife Workshop'),
(9,'Riya Sen','2025-09-30','Education'),
(10,'Manoj Gupta','2025-08-25','Tourism');

INSERT INTO MigrationRecord (MigrationID, SpeciesID, Date, FromHabitatID, ToHabitatID) VALUES
(1,3,'2025-07-01',3,2),
(2,1,'2025-05-20',1,8),
(3,2,'2025-08-15',2,1),
(4,4,'2025-03-10',5,3),
(5,5,'2025-09-22',4,9),
(6,6,'2025-08-05',6,1),
(7,7,'2025-07-10',10,7),
(8,8,'2025-08-18',7,6),
(9,9,'2025-10-10',9,5),
(10,10,'2025-06-25',8,2);

INSERT INTO LivesIn (SpeciesID, HabitatID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO ProtectedBy (SpeciesID, StaffID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO Studies (ResearchID, SpeciesID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO AwarenessCampaign (CampaignID, Name, TargetAudience, Date) VALUES
(1,'Save Tigers','General Public','2025-09-10'),
(2,'Protect Elephants','School Students','2025-08-15'),
(3,'Snow Awareness','Local Communities','2025-07-05'),
(4,'Rhino Rally','Wildlife Enthusiasts','2025-09-20'),
(5,'Turtle Week','Tourists','2025-10-05'),
(6,'Dolphin Day','Fishermen','2025-06-08'),
(7,'Birds & Biodiversity','Researchers','2025-09-12'),
(8,'Panda Parade','Children','2025-07-30'),
(9,'Snake Safety','Villagers','2025-10-12'),
(10,'Monkey Mind','Forest Rangers','2025-09-25');

INSERT INTO Attends (VisitorID, CampaignID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO RescueOperation (OperationID, SpeciesID, StaffID, Date, Outcome) VALUES
(1, 1, 1, '2025-07-12', 'Tiger relocated safely'),
(2, 2, 2, '2025-08-04', 'Elephant freed from trap'),
(3, 3, 3, '2025-09-01', 'Snow leopard tagged and released'),
(4, 4, 4, '2025-07-19', 'Rhino treated for wound'),
(5, 5, 5, '2025-08-23', 'Turtle saved from fishing net'),
(6, 6, 6, '2025-09-02', 'Dolphin guided back to river'),
(7, 7, 7, '2025-08-28', 'Peafowl rescued from road accident'),
(8, 8, 8, '2025-10-03', 'Red panda safely moved'),
(9, 9, 9, '2025-09-15', 'King cobra rescued from village'),
(10, 10, 10, '2025-08-10', 'Macaque released after medical check');

ALTER TABLE ConservationProgram MODIFY ProgramID INT AUTO_INCREMENT;
