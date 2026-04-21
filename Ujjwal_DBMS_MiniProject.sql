-- ============================================
-- HOSPITAL MANAGEMENT SYSTEM (COMPLETE PROJECT)
-- ============================================


-- ============================================
-- STEP 1: CREATE TABLES
-- ============================================

-- PATIENTS TABLE
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,             -- Unique ID
    Name TEXT NOT NULL,                    -- Cannot be null
    Age INT CHECK(Age > 0),                -- Age must be positive
    Gender TEXT,
    Phone TEXT UNIQUE                      -- No duplicate numbers
);


-- DOCTORS TABLE
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name TEXT NOT NULL,
    Specialization TEXT,
    Fees INT CHECK(Fees > 0)               -- Fees must be positive
);


-- APPOINTMENTS TABLE
-- Links patients with doctors
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate TEXT,

    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


-- BILLS TABLE
-- Stores billing details
CREATE TABLE Bills (
    BillID INT PRIMARY KEY,
    PatientID INT,
    Amount INT CHECK(Amount > 0),
    BillDate TEXT,

    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);



-- ============================================
-- STEP 2: INSERT SAMPLE DATA
-- ============================================

-- Patients
INSERT INTO Patients VALUES (1, 'Rahul', 25, 'Male', '9876543210');
INSERT INTO Patients VALUES (2, 'Neha', 22, 'Female', '9123456780');
INSERT INTO Patients VALUES (3, 'Amit', 30, 'Male', '9012345678');

-- Doctors
INSERT INTO Doctors VALUES (1, 'Dr. Sharma', 'Cardiologist', 500);
INSERT INTO Doctors VALUES (2, 'Dr. Mehta', 'Dermatologist', 400);

-- Appointments
INSERT INTO Appointments VALUES (1, 1, 1, '2024-03-01');
INSERT INTO Appointments VALUES (2, 2, 2, '2024-03-02');

-- Bills
INSERT INTO Bills VALUES (1, 1, 500, '2024-03-01');
INSERT INTO Bills VALUES (2, 2, 400, '2024-03-02');



-- ============================================
-- STEP 3: CREATE VIEW (ADVANCED)
-- ============================================

-- VIEW: Appointment Details
CREATE VIEW AppointmentDetails AS
SELECT 
    Patients.Name AS PatientName,
    Doctors.Name AS DoctorName,
    Doctors.Specialization,
    Appointments.AppointmentDate
FROM Appointments
JOIN Patients ON Appointments.PatientID = Patients.PatientID
JOIN Doctors ON Appointments.DoctorID = Doctors.DoctorID;



-- ============================================
-- STEP 4: BASIC QUERIES (MENU-LIKE)
-- ============================================

-- View all patients
SELECT * FROM Patients;

-- View all doctors
SELECT * FROM Doctors;

-- View appointments
SELECT * FROM Appointments;

-- View bills
SELECT * FROM Bills;



-- ============================================
-- STEP 5: ADVANCED QUERIES
-- ============================================

-- Find all cardiologists
SELECT * FROM Doctors WHERE Specialization = 'Cardiologist';

-- Find patient appointment details (JOIN)
SELECT Patients.Name, Doctors.Name
FROM Patients
JOIN Appointments ON Patients.PatientID = Appointments.PatientID
JOIN Doctors ON Appointments.DoctorID = Doctors.DoctorID;

-- Total revenue from bills
SELECT SUM(Amount) AS TotalRevenue FROM Bills;

-- Patients who have appointments
SELECT Name FROM Patients
WHERE PatientID IN (SELECT PatientID FROM Appointments);

-- Use VIEW
SELECT * FROM AppointmentDetails;



-- ============================================
-- STEP 6: CONSTRAINT MANAGEMENT (EXPLANATION)
-- ============================================

-- Example: Add constraint (SQLite workaround)
ALTER TABLE Doctors
ADD COLUMN TempCheck INT CHECK (Fees > 0);

-- NOTE:
-- SQLite does not support DROP CONSTRAINT directly.
-- To remove a constraint:
-- 1. Create new table without constraint
-- 2. Copy data
-- 3. Drop old table
-- 4. Rename new table



-- ============================================
-- STEP 7: SIMULATED MENU SYSTEM
-- ============================================

-- Option 1 → View Patients
SELECT * FROM Patients;

-- Option 2 → View Doctors
SELECT * FROM Doctors;

-- Option 3 → View Revenue
SELECT SUM(Amount) FROM Bills;



-- ============================================
-- END OF PROJECT
-- ============================================