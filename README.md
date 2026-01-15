# WildTrack – Wildlife Conservation Database Management System

A comprehensive relational database management system designed to efficiently organize and analyze wildlife conservation data. WildTrack demonstrates core DBMS concepts through a production-ready schema supporting species tracking, habitat management, conservation programs, research activities, and rescue operations.

---

## Overview

WildTrack addresses fragmentation in wildlife conservation data management by providing a centralized platform for storing, querying, and visualizing conservation-related information. The system integrates a normalized MySQL database backend with an interactive Flask + HTML dashboard, enabling conservation authorities and researchers to make data-driven decisions for biodiversity protection.

### Key Objectives

- Centralize wildlife data storage across species, habitats, staff, researchers, and conservation programs
- Maintain referential integrity and reduce data redundancy 
- Support analytical queries for research and decision-making
- Automate routine operations through triggers, stored procedures, and user-defined functions
- Provide interactive visualizations for conservation insights

---

## Technology Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Database Engine | MySQL 8.0+ | Relational data storage and management |
| Backend | Flask (Python) | REST API and data processing |
| Frontend | HTML5, CSS3, Bootstrap | Responsive web interface |
| Visualization | Chart.js | Interactive statistics and analytics |
| Data Format | JSON | Backend-frontend communication |

---

## Database Schema Overview

### Core Entities

| Entity | Purpose | Key Attributes |
|--------|---------|-----------------|
| **Species** | Tracks animal species | SpeciesID, Name, Category, EndangeredStatus, Population |
| **Habitat** | Records natural environments | HabitatID, Name, Location, Area, Climate, Type |
| **Staff** | Manages personnel records | StaffID, Name, Role, Contact, AssignedHabitatID |
| **ConservationProgram** | Tracks protection initiatives | ProgramID, Name, Type, Budget, StartDate, EndDate |
| **Researcher** | Records research team members | ResearchID, Name, Field, Affiliation, Contact |
| **Sponsorship** | Documents funding sources | SponsorID, Name, Type, Contribution, ProgramID |
| **MedicalRecord** | Maintains health records | RecordID, SpeciesID, HealthStatus, LastCheckupDate |
| **Visitor** | Logs visitor information | VisitorID, Name, VisitDate, Purpose |
| **MigrationRecord** | Tracks species movement | MigrationID, SpeciesID, Date, FromHabitatID, ToHabitatID |
| **AwarenessCampaign** | Records outreach programs | CampaignID, Name, TargetAudience, Date |
| **RescueOperation** | Documents rescue missions | OperationID, SpeciesID, StaffID, Date, Outcome |

### Relationship Tables (Junction Tables)

| Relationship | Purpose |
|--------------|---------|
| **LivesIn** | Many-to-many: Species ↔ Habitat |
| **ProtectedBy** | Many-to-many: Species ↔ Staff |
| **Studies** | Many-to-many: Researcher ↔ Species |
| **Attends** | Many-to-many: Visitor ↔ AwarenessCampaign |

---

## Database Features Implemented

### DDL (Data Definition Language)
- Database creation and initialization
- Table creation with appropriate data types and constraints
- Primary and foreign key definitions
- Index creation for query optimization

### DML (Data Manipulation Language)
- Insertion of sample data across all 11 entities
- Update operations (e.g., budget modifications)
- Delete operations with referential integrity enforcement
- Realistic data spanning 10 species, 10 habitats, 10 staff members, and 10 conservation programs

### Query Operations

**Simple & Aggregate Queries:**
- Average budget calculation across all programs
- Maximum checkup dates per species
- Count of species by category
- Aggregate statistics using AVG, MAX, MIN, COUNT, SUM

**Correlated Queries:**
- Species population comparisons within categories
- Conditional queries referencing outer query columns

**Nested Queries:**
- Species with conservation budgets exceeding thresholds
- Filtered data based on subquery results
- Multi-level query nesting for complex analysis

**Join Operations:**
- INNER JOINs across Species, Habitat, Staff, and Medical Records
- Multi-table joins for comprehensive data retrieval
- Relationship traversal using junction tables

### Stored Procedures
- **AddConservationProgram**: Inserts new conservation initiatives with parameters
- **FetchSpeciesByHabitat**: Retrieves species native to specific habitats
- Parameterized procedures for reusable database operations

### User-Defined Functions
- **SpeciesCountByCategory**: Returns count of species in a given category (e.g., Mammal, Bird, Reptile)
- **TotalSponsorship**: Calculates aggregate funding for a specific program
- Scalar functions returning computed values based on database state

### Triggers
- **UpdatePopulationAfterRescue**: Automatically increments species population upon rescue operation insertion
- **UpdateEndangeredStatus**: Modifies endangered status based on population thresholds
- Event-driven automation eliminating manual updates

---

---

## Installation & Setup

### Prerequisites
- MySQL 8.0 or higher
- Python 3.8+
- Git

### Step 1: Clone the Repository
```bash
git clone https://github.com/KAshyapk07/WildTrack-wildlife-conservation-system.git
cd WildTrack
```

### Step 2: Create the Database
```bash
mysql -u root -p < ddl_queries.sql
```
Enter your MySQL root password when prompted.

### Step 3: Populate Sample Data
```bash
mysql -u root -p wildlife_conservation < dml_queries.sql
mysql -u root -p wildlife_conservation < dml_1.sql
```

### Step 4: Install Backend Dependencies
```bash
pip install -r requirements.txt
```

### Step 5: Configure Database Connection
Update the Flask application with your MySQL credentials:

```python
DATABASE_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'your_password',
    'database': 'wildlife_conservation'
}
```

### Step 6: Run the Flask Server
```bash
python app.py
```
Access the dashboard at http://localhost:5000

---

## Usage Guide

### Querying the Database

View all species:

```sql
SELECT * FROM Species;
```

Species by conservation program:
```sql
SELECT s.Name, cp.Name AS Program, cp.Budget 
FROM Species s 
JOIN ConservationProgram cp ON s.SpeciesID = cp.SpeciesID;
```

Total sponsorship by program:
```sql
SELECT cp.Name, SUM(s.Contribution) AS TotalFunding
FROM ConservationProgram cp
LEFT JOIN Sponsorship s ON cp.ProgramID = s.ProgramID
GROUP BY cp.ProgramID, cp.Name;
```

Rescue operations with staff details:
```sql
SELECT ro.Date, s.Name AS Species, st.Name AS Staff, ro.Outcome
FROM RescueOperation ro
JOIN Species s ON ro.SpeciesID = s.SpeciesID
JOIN Staff st ON ro.StaffID = st.StaffID
ORDER BY ro.Date DESC;
```

#### Running Provided SQL Scripts
Execute complex queries:

```bash
mysql -u root -p wildlife_conservation < join_nested_aggregate.sql
```

Load triggers and procedures:
```bash
mysql -u root -p wildlife_conservation < trig_pro_func_check.sql
```

### Using the Dashboard
 - Population Analytics: View species population trends by habitat and category
 - Program Overview: Track conservation program budgets and durations
 - Staff & Resources: Monitor staff assignments and rescue operations
 - Research Metrics: Display active researchers and their study subjects
 - Financial Summary: Visualize sponsorship contributions and program costs

---

## Dashboard Features

| Page	| Functionality |  
|-----------|-----------|  
| Dashboard |	Overview statistics, population charts, program summary |  
| Join Queries |	Species habitat associations, staff assignments, rescue operations |
| Nested Queries |	Endangered species, high-budget programs, active researchers |  
| Aggregate Functions |	Population statistics, average program budget, sponsorship totals |
| Triggers & Automation |	Real-time population updates, status changes, operational logs |
| Procedures & Functions |	Habitat-based queries, species counts, funding calculations |  

---

### Academic Relevance

This project demonstrates competency in fundamental and advanced DBMS concepts:
- Database Design: Entity-Relationship modeling and relational schema transformation
- Normalization Theory: Application of 1NF, 2NF, and 3NF principles
- Referential Integrity: Foreign key constraints and cascade operations
- SQL Proficiency: DDL, DML, complex queries (joins, subqueries, aggregations)
- Advanced Features: Triggers for automation, stored procedures for code reuse, functions for computation
- Systems Integration: Backend-frontend communication and data visualization

### Course Context
Course: UE23CS351A – Database Management Systems
Semester: 5th Semester, B.Tech Computer Science & Engineering
Institution: PES University, Bangalore
Academic Year: AUG – DEC 2025

Sample Data Statistics
- 10 Species (Tigers, Elephants, Snow Leopards, etc.)
- 10 Habitats (Sundarbans, Kaziranga, Himalayan reserves, etc.)
- 10 Staff Members (Rangers, Veterinarians, Ecologists)
- 10 Conservation Programs (with budgets ranging from 200K to 1.2M)
- 10 Researchers (affiliated with universities and research institutes)
- 10 Sponsorships (from NGOs, corporations, and government)

---

## Authors
Project Team:
Kashyap K (PES2UG23CS263)
Rohan S Nayak (PES2UG24CS820)

Guided by: Prof. Shilpa S, Department of Computer Science and Engineering, PES University

---

References
- MySQL 8.0 Documentation – Official MySQL Reference Manual (https://dev.mysql.com/doc/)
- W3Schools MySQL Tutorial – SQL fundamentals and examples (https://www.w3schools.com/mysql/)
- Flask Documentation – Web framework for Python (https://flask.palletsprojects.com/)
- Mozilla Developer Network – HTML, CSS, JavaScript references (https://developer.mozilla.org/)
- Elmasri & Navathe – Fundamentals of Database Systems – Core DBMS concepts
- C.J. Date – An Introduction to Database Systems – Relational theory and normalization


