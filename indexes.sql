--Tworzenie indeksów
USE Projekt2

--W ka¿dej tabeli mo¿e wystêpowaæ jeden indeks klastrowany, zosta³y one utworzone przy konstrukcji kluczy g³ównych dla wszystkich tabel
--Tabela Employess
--CREATE CLUSTERED INDEX i_emp_1 on Employees(EmployeeID) --przy braku kluczy g³ównych w ten sposób mo¿emy dodaæ indeks klastrowany
CREATE NONCLUSTERED INDEX i_emp_2 on Employees(Employee_firstname)
CREATE NONCLUSTERED INDEX i_emp_3 on Employees(Employee_lastname)

--Tabela Service_dict
CREATE NONCLUSTERED INDEX i_ser_2 on Service_dict(Service_name)

--Tabela Patients
CREATE NONCLUSTERED INDEX i_pat_2 on Patients(Patient_firstname)
CREATE NONCLUSTERED INDEX i_pat_3 on Patients(Patient_lastname)

--Tabela Visits
CREATE NONCLUSTERED INDEX i_vis_2 on Visits(Visit_time)

--Tabela Medicine_dict
CREATE NONCLUSTERED INDEX i_med_2 on Medicine_dict(Medicine_name)

--Tabela Medicine
CREATE NONCLUSTERED INDEX i_med_inf_2 on Medicine(Prescription_date_end)

--Tabela Disease_perm_dict
CREATE NONCLUSTERED INDEX i_dis_2 on Disease_perm_dict(Disease_name)

--Tabela Additional_info_patients
CREATE NONCLUSTERED INDEX i_add_2 on Additional_info_patients(PatientID)



