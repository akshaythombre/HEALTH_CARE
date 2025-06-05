USE health_care;

-- How many patients are currently admitted to the hospital?
SELECT COUNT(*) AS TotalPatients
FROM Admissions
WHERE DischargeDate IS NOT NULL;

-- List all doctors and the number of patients they have treated
SELECT Doctors.Name AS DoctorName, COUNT(Admissions.AdmissionID) AS PatientsTreated
FROM Doctors
LEFT JOIN Admissions ON Doctors.DoctorID = Admissions.DoctorID
GROUP BY Doctors.Name;



-- What is the total billing amount for all patients in the database?
SELECT SUM(BillingAmount) AS TotalBilling
FROM Admissions;

-- Which hospital has admitted the highest number of patients?
SELECT Hospitals.Name AS HospitalName, COUNT(Admissions.AdmissionID) AS PatientCount
FROM Hospitals
JOIN Admissions ON Hospitals.HospitalID = Admissions.HospitalID
GROUP BY Hospitals.Name
ORDER BY PatientCount DESC
LIMIT 1;

-- Get the details of all patients with a specific medical condition (e.g., "Diabetes").
SELECT *
FROM Patients
WHERE MedicalCondition = 'Diabetes' ;

-- List all admissions along with the name of the patient, doctor, and hospital.
SELECT 
    Admissions.AdmissionID, 
    Patients.Name AS PatientName, 
    Doctors.Name AS DoctorName, 
    Hospitals.Name AS HospitalName, 
    Admissions.DateOfAdmission, 
    Admissions.DischargeDate
FROM Admissions
JOIN Patients ON Admissions.PatientID = Patients.PatientID
JOIN Doctors ON Admissions.DoctorID = Doctors.DoctorID
JOIN Hospitals ON Admissions.HospitalID = Hospitals.HospitalID;

-- Find the average age of patients in the database.
SELECT AVG(Age) AS AverageAge
FROM Patients;

-- What are the top 3 most common medical conditions among patients?

SELECT MedicalCondition, COUNT(*) AS Frequency
FROM Patients
GROUP BY MedicalCondition
ORDER BY Frequency DESC
LIMIT 3;

-- List all patients along with their most recent admission date.

SELECT 
    Patients.Name AS PatientName, 
    MAX(Admissions.DateOfAdmission) AS LastAdmissionDate
FROM Patients
JOIN Admissions ON Patients.PatientID = Admissions.PatientID
GROUP BY Patients.Name;

-- Find the names of patients who were treated by the doctor with the highest number of admissions.
SELECT Name 
FROM Patients 
WHERE PatientID IN (
    SELECT PatientID 
    FROM Admissions 
    WHERE DoctorID = (
        SELECT DoctorID 
        FROM Admissions 
        GROUP BY DoctorID 
        ORDER BY COUNT(*) DESC 
        LIMIT 1
    )
);



-- Find the average billing amount for each hospital, and only display hospitals where the average is above $5,000.
SELECT Name 
FROM Hospitals 
WHERE HospitalID IN (
    SELECT HospitalID 
    FROM Admissions 
    GROUP BY HospitalID 
    HAVING AVG(BillingAmount) > 5000
);

-- Rank patients by their age.
SELECT 
    Patients.Name AS PatientName, 
    Patients.Age, 
    RANK() OVER (ORDER BY Patients.Age DESC) AS AgeRank
FROM Patients;

-- Create a view to show the details of patients currently admitted to the hospital.
CREATE VIEW CurrentAdmissions AS
SELECT 
    Admissions.AdmissionID, 
    Patients.Name AS PatientName, 
    Patients.Age, 
    Patients.Gender, 
    Admissions.DateOfAdmission, 
    Admissions.RoomNumber, 
    Hospitals.Name AS HospitalName
FROM Admissions
JOIN Patients ON Admissions.PatientID = Patients.PatientID
JOIN Hospitals ON Admissions.HospitalID = Hospitals.HospitalID
WHERE Admissions.DischargeDate IS NULL;