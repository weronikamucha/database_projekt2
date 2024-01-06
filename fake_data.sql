--Tworzenie rekord�w w tabelach
Use Projekt2

--Tabela Employess
INSERT INTO Employees (EmployeeID, Employee_firstname, Employee_lastname, Title, Phone_number)
VALUES 
    (1, 'Jan', 'Kowalczyk', 'Specjalista medycyny rodzinnej', '873948125'),
    (2, 'Piotr', 'Nowak', 'Stomatolog', '790643011'),
    (3, 'Katarzyna', 'Kasia', 'Po�o�na', '890765231'),
    (4, 'Martyna', 'Wolska', 'Piel�gniarka', '456391293'),
    (5, 'Bo�ena', 'D�browska', 'Pediatra', '456317843'),
    (6, 'Helena', 'Jaroniewska', 'Specjalista medycyny rodzinnej', '984293451');

--Tabela Service_dict
INSERT INTO Service_dict (ServiceID, Service_name, Price)
VALUES 
    (1, 'Konsultacja og�lna', 100.00),
    (2, 'Morfologia konsultacja', 50.00),
    (3, 'Szczepienie', 50.00),
    (4, 'Konsultacja stomatologiczna', 100.00),
    (5, 'Leczenie kana�owe', 200.00);

--Tabela Patients
INSERT INTO Patients (PatientID, Patient_firstname, Patient_lastname, PESEL, Registration_date, Birth_date)
VALUES 
    (1, 'Weronika', 'Kowalska', '94070314922', '2021-12-01', '1994-07-03'),
    (2, 'Aleksandra', 'Janowska', '68053193344', '2021-12-11', '1968-05-31'),
    (3, 'Magdalena', 'G�owacka', '74101135684', '2022-02-11', '1974-10-11'),
    (4, 'Lara', 'Kwiatkowska', '69091262828', '2020-05-15', '1969-09-12'),
    (5, 'Jola', 'Witkowska', '50042631986', '2021-11-03', '1950-04-26'),
    (6, 'Ewelina', 'Kaniowska', '54011713886', '2020-04-11', '1954-01-17'),
    (7, 'Karolina', 'Gr�da', '82062486586', '2021-02-11', '1982-06-24'),
    (8, 'Kewin', 'Duda', '63040259557', '2021-07-29', '1963-04-02'),
    (9, 'Aureliusz', 'Jakubowski', '48111842295', '2020-12-19', '1948-11-18'),
    (10, 'Joachim', 'Wojciechowski', '06221399913', '2021-11-26', '2006-02-13'),
    (11, 'Henryk', 'Mazurek', '82040788431', '2022-09-11', '1982-04-07'),
    (12, 'Ludwik', 'Kami�ski', '57081027735', '2021-10-10', '1957-08-10'),
    (13, 'Aleksandra', 'Dola', '01250925361', '2023-11-05', '2001-05-09'),
    (14, 'Henryk', 'Mazurek', '03292215518', '2023-04-04', '2003-09-22');

--Tabela Visits
INSERT INTO Visits (VisitID, EmployeeID, Visit_time, ServiceID, PatientID)
VALUES 
    (1, 1, '2022-10-12T12:32:00', 3, 2),
    (2, 3, '2022-04-23T15:30:00', 4, 8),
    (3, 4, '2023-07-11T14:33:00', 2, 11),
    (4, 2, '2023-10-12T07:25:00', 3, 12),
    (5, 2, '2023-01-08T12:08:00', 2, 1),
    (6, 3, '2022-02-24T13:09:00', 2, 3),
    (7, 2, '2023-09-25T12:10:00', 4, 5);

--Tabela Medicine_dict
INSERT INTO Medicine_dict (MedicineID, Medicine_name, Active_substance, Description)
VALUES 
    (1, 'Fentanyl Actavis', 'Fentanyl', 'Opioidowy lek przeciwb�lowy o silnym dzia�aniu.'),
    (2, 'Pulnozin', 'Karbocysteina', NULL),
    (3, 'Kidofen duo', 'Ibuprofen i Paracetamol', 'Lek jest lekiem przeciwb�lowym, przeciwgor�czkowym i przeciwzapalnym.'),
    (4, 'Humalog', 'Insulina lizpro', 'Preparat jest dwufazow� zawiesin� insuliny lispro (szybkodzia�aj�cy analog insuliny ludzkiej) i zawiesiny protaminowej insuliny lispro (analog insuliny ludzkiej o po�rednim czasie dzia�ania) Insulina zmniejsza st�enie glukozy we krwi.'),
    (5, 'Concor COR', NULL, NULL);

--Tabela Medicine
INSERT INTO Medicine (VisitID, MedicineID, Prescription_date_end, Medicine_infoID)
VALUES 
    (1, 1, '2022-12-12', 1),
    (2, 1, NULL, 2),
    (2, 2, '2022-05-23', 3),
    (3, 4, '2023-08-11', 4),
    (4, 3, NULL, 5),
    (5, 1, '2022-07-23', 6);

--Tabela Disease_perm_dict
INSERT INTO Disease_perm_dict (DiseaseID, Disease_name, Description)
VALUES 
    (1, 'Cukrzyca', 'Przewlek�a choroba metaboliczna wynikaj�ca z zaburzonego wydzielania lub dzia�ania insuliny'),
    (2, 'Stan po przebytym udarze', NULL),
    (3, 'Zapalenie staw�w', 'Grupa chor�b, w przebiegu kt�rych dochodzi do stanu zapalnego chrz�stki stawowej, a w konsekwencji do jej uszkodzenia'),
    (4, 'Padaczka', 'Jest przewlek�� chorob� m�zgu, polegaj�c� na wyst�powaniu powtarzaj�cych si� napad�w padaczkowych.'),
    (5, 'Osteoporoza', 'To choroba, kt�ra dotyka uk�ad szkieletowy cz�owieka. W przebiegu tej choroby dochodzi do zmniejszenia g�sto�ci ko�ci.'),
    (6, 'Oty�o��', 'Stan, kt�ry charakteryzuje si� zwi�kszon� ilo�ci� tkanki t�uszczowej.'),
    (7, 'Stwardnienie rozsiane', NULL);

--Tabela Additional_info_patients
INSERT INTO Additional_info_patients (PatientID, DiseaseID, EmployeeID, Additional_info, Additional_infoID)
VALUES 
    (1, 1, 6, 'U pacjenta po wykonanych badaniach oraz pomiarze glikemii i konsultacji oraz rozmowie zosta�a zdiagnozowana cukrzyca.', 1),
    (2, 1, 1, 'Doustny test obci��enia glukoz� wskaza� jednoznacznie na cukrzyc�.', 2),
    (11, 5, 5, NULL, 3),
    (12, 4, 1, 'Badanie EEG potwierdzi�o podejrzenia padaczki.', 4),
    (3, 3, 5, 'U pacjenta stwierdzono zapalenie staw�w.', 5);