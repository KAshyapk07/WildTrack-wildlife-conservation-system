# WildTrack - Wildlife Conservation Management System

**WildTrack** is a full-featured **Flask + MySQL** application designed to manage, track, and visualize wildlife conservation data.  
It integrates database triggers, stored procedures, and analytical dashboards to simulate a real-world conservation management system.

---

## Features

-  **Interactive Dashboard** — View total species, endangered count, active programs, and total sponsorship.
-  **Species & Habitat Management** — Manage habitats, staff, and conservation programs.
-  **Database Logic Demo** — Built-in triggers, stored procedures, and functions.
-  **Data Visualization** — Real-time analytics with Chart.js.
-  **SQL Joins, Nested & Aggregate Queries** — See complex queries in action.
-  **Educational Project** — Perfect for DBMS labs or portfolio demos.

---

##  Technologies Used

| Layer | Technology |
|-------|-------------|
| Backend | Flask (Python) |
| Database | MySQL |
| Frontend | HTML5, CSS3, Bootstrap 5, Chart.js |
| Data Logic | SQL Triggers, Procedures, Functions |

---

## 🗃️ Database Setup (MySQL)

Run the following in MySQL Workbench or CLI:

```sql
SOURCE ddl_queries.sql;
SOURCE dml_1.sql;
```
## Key SQL Logic
### Triggers

##### UpdatePopulationAfterRescue

  After inserting into RescueOperation, it increases that species’ population by 1.

##### UpdateLastCheckup

  Updates Species.EndangeredStatus based on medical record health status.

### Stored Procedures

##### AddConservationProgram() — Adds a new conservation program automatically.

##### GetSpeciesByHabitat(habitat_id) — Returns species belonging to a given habitat.

### Functions

##### TotalSponsorship(program_id) — Returns total sponsorship for a program.

##### SpeciesCountByCategory(category) — Returns number of species by category.

###  Flask Setup and Run
1️⃣ Install Dependencies
pip install flask mysql-connector-python

2️⃣ Run Flask App

If your main file is app.py:

python app.py

3️⃣ Access in Browser

Open:

http://127.0.0.1:5000/

