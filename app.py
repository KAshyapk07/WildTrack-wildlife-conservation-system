from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = "wildtrack_secret"

# ======================================================
# DATABASE CONNECTION
# ======================================================
def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Iamkash2272",
        database="Wildlife_Conservation"
    )

# ======================================================
# 🏠 HOME PAGE
# ======================================================
@app.route('/')
def home():
    db = get_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT COUNT(*) AS total_species FROM Species")
    total_species = cursor.fetchone()['total_species']

    cursor.execute("SELECT COUNT(*) AS endangered_count FROM Species WHERE EndangeredStatus='Endangered'")
    endangered = cursor.fetchone()['endangered_count']

    cursor.execute("SELECT IFNULL(SUM(Contribution), 0) AS total_sponsorship FROM Sponsorship")
    total_sponsorship = cursor.fetchone()['total_sponsorship']

    cursor.execute("SELECT COUNT(*) AS program_count FROM ConservationProgram")
    program_count = cursor.fetchone()['program_count']

    cursor.execute("""
        SELECT cp.Name AS ProgramName, s.Name AS SpeciesName, cp.Budget, cp.StartDate
        FROM ConservationProgram cp
        JOIN Species s ON cp.SpeciesID = s.SpeciesID
        ORDER BY cp.StartDate DESC
        LIMIT 5
    """)
    recent = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "index.html",
        total_species=total_species,
        endangered_count=endangered,
        total_sponsorship=total_sponsorship,
        program_count=program_count,
        recent_programs=recent,
        active_page='home'
    )

# ======================================================
# 🐾 SPECIES
# ======================================================
@app.route('/species')
def species():
    db = get_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Species")
    data = cursor.fetchall()
    cursor.close()
    db.close()
    return render_template('species.html', species=data, active_page='species')

# ======================================================
# 🌳 HABITATS
# ======================================================
@app.route('/habitats')
def habitats():
    db = get_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Habitat")
    data = cursor.fetchall()
    cursor.close()
    db.close()
    return render_template('habitats.html', habitats=data, active_page='habitats')

# ======================================================
# 💡 PROGRAMS (Add + Delete)
# ======================================================
@app.route('/programs', methods=['GET', 'POST'])
def programs():
    if request.method == 'POST':
        if 'admin' not in session:
            flash("Access denied. Only admin can add programs.", "danger")
            return redirect(url_for('login'))

        name = request.form['name']
        type_ = request.form['type']
        budget = request.form['budget']
        start = request.form['start']
        end = request.form['end']
        species_id = request.form['species_id']

        db = get_connection()
        cursor = db.cursor(dictionary=True)

        #  Find smallest missing ProgramID
        cursor.execute("""
            SELECT MIN(t1.ProgramID + 1) AS next_id
            FROM ConservationProgram t1
            LEFT JOIN ConservationProgram t2 ON t1.ProgramID + 1 = t2.ProgramID
            WHERE t2.ProgramID IS NULL
        """)
        row = cursor.fetchone()
        next_id = row['next_id'] or 1

        cursor.execute("""
            INSERT INTO ConservationProgram (ProgramID, Name, Type, Budget, StartDate, EndDate, SpeciesID)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (next_id, name, type_, budget, start, end, species_id))
        db.commit()
        cursor.close()
        db.close()

        flash(f"✅ Program added successfully (ID = {next_id})", "success")

        # Redirect directly to dashboard to force immediate reload
        return redirect(url_for('programs'))

    # --- GET request ---
    db = get_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT p.ProgramID, p.Name AS ProgramName, p.Type, p.Budget,
               p.StartDate, p.EndDate, s.Name AS SpeciesName
        FROM ConservationProgram p
        LEFT JOIN Species s ON p.SpeciesID = s.SpeciesID
        ORDER BY p.ProgramID DESC
    """)
    programs_data = cursor.fetchall()

    cursor.execute("SELECT SpeciesID, Name FROM Species")
    species_list = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template('programs.html',
                           programs=programs_data,
                           species_list=species_list,
                           active_page='programs')


@app.route('/delete_program/<int:id>', methods=['POST'])
def delete_program(id):
    if 'admin' not in session:
        flash("Access denied. Only admin can delete programs.", "danger")
        return redirect(url_for('login'))

    db = get_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("DELETE FROM ConservationProgram WHERE ProgramID = %s", (id,))
    db.commit()
    cursor.close()
    db.close()
    flash("🗑️ Program deleted successfully.", "info")
    return redirect(url_for('programs'))

# ======================================================
# 🧠 DB LOGIC PAGE
# ======================================================
@app.route('/db_logic')
def db_logic():
    db = get_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT TotalSponsorship(6) AS total_sponsor")
    total_sponsor = cursor.fetchone().get('total_sponsor', 0)

    cursor.execute("SELECT SpeciesCountByCategory('Mammal') AS mammal_count")
    mammal_count = cursor.fetchone().get('mammal_count', 0)

    cursor.close()
    db.close()

    return render_template('db_logic.html',
                           total_sponsor=total_sponsor,
                           mammal_count=mammal_count,
                           active_page='db_logic')

# ======================================================
# 📞 CONTACT
# ======================================================
@app.route('/contact')
def contact():
    return render_template('contact.html', active_page='contact')

# ======================================================
# 📊 DASHBOARD
# ======================================================
@app.route('/dashboard')
def dashboard():
    db = get_connection()
    cursor = db.cursor(dictionary=True)

    # ====== Summary Counts ======
    cursor.execute("SELECT COUNT(*) AS total_species FROM Species")
    total_species = cursor.fetchone()['total_species']

    cursor.execute("SELECT COUNT(*) AS endangered FROM Species WHERE EndangeredStatus='Endangered'")
    endangered = cursor.fetchone()['endangered']

    cursor.execute("SELECT COUNT(*) AS total_programs FROM ConservationProgram")
    total_programs = cursor.fetchone()['total_programs']

    cursor.execute("SELECT IFNULL(SUM(Contribution), 0) AS total_sponsorship FROM Sponsorship")
    total_sponsorship = cursor.fetchone()['total_sponsorship']
    
    cursor.execute("SELECT Name, Population, EndangeredStatus FROM Species WHERE SpeciesID = 1")
    trigger_info = cursor.fetchone()

    # ====== Category-wise report (NEW) ======
    cursor.execute("""
        SELECT 
            Category,
            COUNT(*) AS species_count,
            ROUND(AVG(Population), 2) AS total_pop
        FROM Species
        GROUP BY Category
        ORDER BY species_count DESC
    """)
    category_report = cursor.fetchall()

    # ====== Chart Data ======
    cursor.execute("""
        SELECT COALESCE(Category, 'Unknown') AS Category, SUM(Population) AS total_pop
        FROM Species
        GROUP BY Category
        ORDER BY total_pop DESC
    """)
    pop_data = cursor.fetchall()
    categories = [row['Category'] for row in pop_data]
    populations = [int(row['total_pop']) for row in pop_data]

    # ====== Joins, Nested, Aggregates ======
    cursor.execute("""
        SELECT cp.Name AS ProgramName, s.Name AS SpeciesName, cp.Budget
        FROM ConservationProgram cp
        JOIN Species s ON cp.SpeciesID = s.SpeciesID
        LIMIT 5
    """)
    join_results = cursor.fetchall()

    cursor.execute("""
        SELECT Name FROM Species
        WHERE SpeciesID IN (
            SELECT SpeciesID FROM ConservationProgram WHERE Budget > 1000000
        )
    """)
    nested_results = cursor.fetchall()

    cursor.execute("SELECT AVG(Budget) AS avg_budget FROM ConservationProgram")
    avg_budget = cursor.fetchone()['avg_budget']

    # ====== Function + Procedure Demos ======
    cursor.execute("SELECT TotalSponsorship(6) AS Total_Contribution")
    total_contrib = cursor.fetchone()['Total_Contribution']

    cursor.execute("SELECT SpeciesCountByCategory('Mammal') AS Mammal_Count")
    mammal_count = cursor.fetchone()['Mammal_Count']

    cursor.callproc('GetSpeciesByHabitat', [3])
    proc_species = []
    for result in cursor.stored_results():
        proc_species = result.fetchall()

    cursor.close()
    db.close()

    return render_template(
        'dashboard.html',
        total_species=total_species,
        endangered=endangered,
        total_programs=total_programs,
        total_sponsorship=total_sponsorship,
        categories=categories,
        populations=populations,
        join_results=join_results,
        nested_results=nested_results,
        avg_budget=avg_budget,
        total_contrib=total_contrib,
        mammal_count=mammal_count,
        trigger_info=trigger_info,
        proc_species=proc_species,
        category_report=category_report,  
        active_page='dashboard'
    )


# ======================================================
# 🧠 ADMIN LOGIN
# ======================================================
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if username == 'admin' and password == 'admin123':
            session['admin'] = True
            flash('Login successful! Welcome, Admin.', 'success')
            return redirect(url_for('home'))
        else:
            flash('Invalid credentials!', 'danger')
            return redirect(url_for('login'))

    return render_template('login.html', active_page='login')

@app.route('/logout')
def logout():
    session.pop('admin', None)
    flash('Logged out successfully.', 'info')
    return redirect(url_for('home'))

# ======================================================
# 🧩 MANAGE DATA (Species Management)
# ======================================================
@app.route('/manage')
def manage_data():
    if 'admin' not in session:
        flash('Access denied. Please log in as admin.', 'danger')
        return redirect(url_for('login'))

    db = get_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Species")
    species = cursor.fetchall()
    cursor.execute("SELECT * FROM Habitat")
    habitats = cursor.fetchall()
    cursor.close()
    db.close()

    return render_template('manage.html',
                           species=species,
                           habitats=habitats,
                           active_page='manage')

@app.route('/add_species', methods=['POST'])
def add_species():
    if 'admin' not in session:
        flash('You must be logged in as admin to add species.', 'danger')
        return redirect(url_for('login'))

    name = request.form['Name']
    category = request.form['Category']
    status = request.form['EndangeredStatus']
    pop = request.form['Population']

    db = get_connection()
    cursor = db.cursor(dictionary=True)

    # Find smallest missing SpeciesID (gap fill)
    cursor.execute("""
        SELECT MIN(t1.SpeciesID + 1) AS next_id
        FROM Species t1
        LEFT JOIN Species t2 ON t1.SpeciesID + 1 = t2.SpeciesID
        WHERE t2.SpeciesID IS NULL
    """)
    row = cursor.fetchone()
    next_id = row['next_id'] or 1

    cursor.execute("""
        INSERT INTO Species (SpeciesID, Name, Category, EndangeredStatus, Population)
        VALUES (%s, %s, %s, %s, %s)
    """, (next_id, name, category, status, pop))
    db.commit()
    cursor.close()
    db.close()

    flash(f'✅ New species added successfully (ID = {next_id})!', 'success')
    return redirect(url_for('manage_data'))

@app.route('/delete_species/<int:id>', methods=['POST'])
def delete_species(id):
    if 'admin' not in session:
        flash('Access denied. Only admin can delete data.', 'danger')
        return redirect(url_for('login'))

    db = get_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("DELETE FROM Species WHERE SpeciesID = %s", (id,))
    db.commit()
    cursor.close()
    db.close()
    flash(f'🗑️ Species with ID {id} deleted successfully!', 'info')
    return redirect(url_for('manage_data'))




# ======================================================
# ⚙️ TRIGGER TEST ROUTES (FOR MANAGE PAGE)
# ======================================================
@app.route('/trigger_rescue', methods=['POST'])
def trigger_rescue():
    if 'admin' not in session:
        flash("Access denied. Only admin can trigger database logic.", "danger")
        return redirect(url_for('login'))

    species_id = request.form.get('species_id')
    if not species_id:
        flash("Please select a species to rescue.", "warning")
        return redirect(url_for('manage_data'))

    db = get_connection()
    cursor = db.cursor(dictionary=True)

    # insert into rescue operation (AUTO_INCREMENT ID)
    cursor.execute("""
        INSERT INTO RescueOperation (SpeciesID, StaffID, Date, Outcome)
        VALUES (%s, %s, CURDATE(), %s)
    """, (species_id, 1, 'Rescue operation recorded'))
    db.commit()

    # fetch updated population
    cursor.execute("SELECT Name, Population FROM Species WHERE SpeciesID = %s", (species_id,))
    result = cursor.fetchone()

    cursor.close()
    db.close()

    flash(f"✅ {result['Name']} rescued! Population increased to {result['Population']}.", "success")
    return redirect(url_for('manage_data'))




# ======================================================
# 🚀 RUN APP
# ======================================================
if __name__ == '__main__':
    app.run(debug=True)
