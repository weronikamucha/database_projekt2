-- Tworzenie bazy danych
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Projekt2')
BEGIN
    CREATE DATABASE Projekt2;
END;

USE Projekt2;

--Tworzenie tabel

--Tabela Employess
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employess')
BEGIN
    CREATE TABLE Employees (
        EmployeeID int NOT NULL,
        Employee_firstname nvarchar(20) NOT NULL,
        Employee_lastname nvarchar(20) NOT NULL,
        Title nvarchar(30),
        Phone_number nchar(9),
        PRIMARY KEY CLUSTERED (EmployeeID)
    );
END;

--Tabela Service_dict
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Service_dict')
BEGIN
    CREATE TABLE Service_dict (
		ServiceID int NOT NULL,
        Service_name nvarchar(50) NOT NULL,
        Price money NOT NULL,
        PRIMARY KEY CLUSTERED (ServiceID)
    );
END;

--Tabela Patients
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Patients')
BEGIN
    CREATE TABLE Patients (
        PatientID int NOT NULL,
        Patient_firstname nvarchar(50) NOT NULL,
        Patient_lastname nvarchar(50) NOT NULL,
        PESEL nchar(11) NOT NULL,
        Registration_date datetime NOT NULL,
		Birth_date date NOT NULL, 
        PRIMARY KEY CLUSTERED (PatientID)
    );
END;

--Tabela Visits
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Visits')
BEGIN
    CREATE TABLE Visits (
        VisitID int NOT NULL,
        EmployeeID int NOT NULL,
        Visit_time datetimeoffset(7) NOT NULL,
        ServiceID int NOT NULL,
        PatientID int NOT NULL,
        PRIMARY KEY CLUSTERED (VisitID),
		CONSTRAINT FK_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
        CONSTRAINT FK_Service FOREIGN KEY (ServiceID) REFERENCES Service_dict(ServiceID),
        CONSTRAINT FK_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
    );
END;

--Tabela Medicine_dict
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Medicine_dict')
BEGIN
    CREATE TABLE Medicine_dict (
		MedicineID int NOT NULL,
        Medicine_name nvarchar(50) NOT NULL,
        Active_substance nvarchar(50),
		Description nvarchar(500)
        PRIMARY KEY CLUSTERED(MedicineID)
    );
END;

--Tabela Medicine
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Medicine')
BEGIN
    CREATE TABLE Medicine (
		Medicine_infoID int NOT NULL,
        VisitID int NOT NULL,
        MedicineID int NOT NULL,
		Prescription_date_end datetime, 
        PRIMARY KEY CLUSTERED(Medicine_infoID),
		CONSTRAINT FK_Visit FOREIGN KEY (VisitID) REFERENCES Visits(VisitID),
		CONSTRAINT FK_Medicine FOREIGN KEY (MedicineID) REFERENCES Medicine_dict(MedicineID)
    );
END;

--Tabela Disease_perm_dict
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Disease_perm_dict')
BEGIN
    CREATE TABLE Disease_perm_dict (
		DiseaseID int NOT NULL,
		Disease_name nvarchar(50) NOT NULL,
        Description nvarchar(250),
        PRIMARY KEY CLUSTERED(DiseaseID)
    );
END;

--Tabela Additional_info_patients
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Additional_info_patients')
BEGIN
    CREATE TABLE Additional_info_patients (
		Additional_infoID int NOT NULL,
		PatientID int NOT NULL,
        DiseaseID int NOT NULL,
        EmployeeID int NOT NULL,
		Additional_info text,
        PRIMARY KEY CLUSTERED (Additional_infoID),
		CONSTRAINT FK_Disease FOREIGN KEY (DiseaseID) REFERENCES Disease_perm_dict(DiseaseID),
		CONSTRAINT FK_Patient_AddInfo FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
		CONSTRAINT FK_Employee_AddInfo FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    );
END;



