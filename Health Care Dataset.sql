CREATE DATABASE health_care;
USE health_care;

-- Table: Patients
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    BloodType VARCHAR(3),
    MedicalCondition VARCHAR(100)
);

-- Table: Doctors
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100)
);

-- Table: Hospitals
CREATE TABLE Hospitals (
    HospitalID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100)
);

-- Table: Admissions
CREATE TABLE Admissions (
    AdmissionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    HospitalID INT,
    DateOfAdmission DATE,
    RoomNumber INT,
    AdmissionType VARCHAR(50),
    DischargeDate DATE,
    BillingAmount DECIMAL(10, 2),
    Medication VARCHAR(100),
    TestResults VARCHAR(50),
    InsuranceProvider VARCHAR(100),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID)
);

-- Insert Sample Data for Patients
INSERT INTO Patients (Name, Age, Gender, BloodType, MedicalCondition)
VALUES
('Tiffany Ramirez', 81, 'Female', 'O-', 'Diabetes'),
('Ruben Burns', 35, 'Male', 'O+', 'Asthma'),
('Chad Byrd', 61, 'Male', 'B-', 'Obesity'),
('Antonio Frederick', 49, 'Male', 'B-', 'Asthma'),
('Mrs. Brandy Flowers', 51, 'Male', 'O-', 'Arthritis');

-- Insert Sample Data for Doctors
INSERT INTO Doctors (Name)
VALUES
('Patrick Parker'),
('Diane Jackson'),
('Paul Baker'),
('Brian Chandler'),
('Dustin Griffin');

-- Insert Sample Data for Hospitals
INSERT INTO Hospitals (Name)
VALUES
('Wallace-Hamilton'),
('Burke, Griffin and Cooper'),
('Walton LLC'),
('Garcia Ltd'),
('Jones, Brown and Murray');

-- Insert Sample Data for Admissions
INSERT INTO Admissions (PatientID, DoctorID, HospitalID, DateOfAdmission, RoomNumber, AdmissionType, DischargeDate, BillingAmount, Medication, TestResults, InsuranceProvider)
VALUES
(1, 1, 1, '2022-11-17', 146, 'Elective', '2022-12-01', 37490.98, 'Aspirin', 'Inconclusive', 'Medicare'),
(2, 2, 2, '2023-06-01', 404, 'Emergency', '2023-06-15', 47304.06, 'Lipitor', 'Normal', 'UnitedHealthcare'),
(3, 3, 3, '2019-01-09', 292, 'Emergency', '2019-02-08', 36874.90, 'Lipitor', 'Normal', 'Medicare'),
(4, 4, 4, '2020-05-02', 480, 'Urgent', '2020-05-03', 23303.32, 'Penicillin', 'Abnormal', 'Medicare'),
(5, 5, 5, '2021-07-09', 477, 'Urgent', '2021-08-02', 18086.34, 'Paracetamol', 'Normal', 'UnitedHealthcare');






