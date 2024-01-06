--Procedura sk³adowana
--Procedura po podaniu numeru id pacjenta ma na celu podanie: 
--imienia, nazwiska, wieku, ile lat jest zarejestrowany w przychodni, imienia lekarza, nazwiska lekarza (jeœli w tabeli Additional_info_patients 
--nie pojawia siê przypisany lekarz to dostaniemy brak zapisu przy imieniu i nazwisku)

CREATE PROCEDURE Patient_Info @patient_id int
AS
DECLARE
    @firstname nchar(30),
    @lastname nchar(30),
    @age int,
    @years int, 
    @firstname_doct nchar(30),
    @lastname_doct nchar(30)

BEGIN
    SELECT @firstname = Patient_firstname,
           @lastname = Patient_lastname,
           @age = DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, Birth_date),
           @years = DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, Registration_date)
    FROM Patients
    WHERE [PatientID] = @patient_id;

    SELECT TOP 1
           @firstname_doct = emp.Employee_firstname,
           @lastname_doct = emp.Employee_lastname
    FROM Patients pat
    LEFT JOIN Additional_info_patients addit ON pat.PatientID = addit.PatientID
    LEFT JOIN Employees emp ON addit.EmployeeID = emp.EmployeeID
    WHERE pat.PatientID = @patient_id;

    PRINT('Patient Firstname is:' + @firstname)
    PRINT('Patient Lastname is:' + @lastname)
    PRINT('Patient Age is:' + STR(@age))
    PRINT('Patient has been in the clinic for :' + STR(@years) + ' years')
    PRINT('Patient is assigned to a doctor named  :' + ISNULL(@firstname_doct, '') + ' ' + ISNULL(@lastname_doct, ''))
END
GO

--Przyk³adowe uruchomienie procedury
Exec Patient_Info @patient_id = 2
Exec Patient_Info @patient_id = 4 --brak prowadz¹cego lekarza