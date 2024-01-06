# Projekt 2: temat numer 7

## Opis bazy danych i dokumentacja
System informacji medycznych: Do przechowywania informacji o usługach medycznych (typ money), czasie wizyt pacjentów (typ datetimeoffset) i dodatkowych danych o pacjentach w formacie JSON.

W bazie będziemy przechowywać informacje medyczne małej placówki typu przychodnia prywatna.
Zgromadzone dane dotyczą pracowników, pacjentów, przepisywanych leków, zdiagnozowanych chorób oraz dostępnych usług medycznych wraz z dodatkowymi informacjami. Przechowywane dane dotyczą też poszczególnych wizyt.

### Shemat bazy danych
Na schemacie pokazany został układ tabel w bazie wraz z relacjami, konstrukcja bazy danych odbywa się zgodnie z plikiem: **create_database.sql**.

<img width="451" alt="Diagram_2" src="https://github.com/weronikamucha/database_projekt2/assets/115482647/fa312c89-acc5-4bc1-b13c-8973093881bd">

Utworzenie tabeli na przykładzie tabeli Visits:

```
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
```

### Tabele
Tabele wchodzące w skład bazy opisane zostały poniżej.
1. Patients:
Kolumny: PatientID (klucz główny), Patient_firstname, Patient_lastname, PESEL, Registration_date, Birth_date
W tabeli nadajemy numer id dla pacjentów w bazie wraz z imionami i nazwiskami, dodatkowo zbieramy unikalny numer PESEL, na podstawie którego jesteśmy w stanie rozróżnić pacjentów oraz określić płeć zgodnie z zapisanym założeniem. Zapisujemy datę rejestracji pacjenta w bazie.
2. Employees:
Kolumny: EmployeeID (klucz główny), Employee_firstname, Employee_lastname, Title, Phone_number
W tabeli zbieramy dane dotyczące pracowników, nadajemy numer id do imion i nazwisk, kolumna Title opisuje stanowisko pracownika, dodajemy też numer kontaktowy w razie nagłych wypadków.
3. Visits:
Kolumny: VisitID (klucz główny), EmployeeID, Visit_time, ServiceID, PatientID
Tabela zawiera historię wizyt, zapisujemy unikalny numer id, pracownika, który przeprowadził wizytę. W kolumnie Visit_time stosujemy typ danych datetimeoffset, który stosowany jest do przechowywania informacji o dacie i czasie wraz z informacją o przesunięciu czasowym (offset). Uzasadnieniem na wybór takie typu danych jest łatwość przechowywania informacji z przesunięciem czasowym oraz zachowanie informacji o czasie letnim. W tabeli w kolumnie ServiceID zapisujemy numer usługi medycznej. Ostatnia kolumna dotyczy numeru id pacjenta.
4. Medicine:
Kolumny: VisitID, MedicineID ((klucz główny), Prescription_date_end
W tabeli zbieramy informacje dotycząca numeru leku i wizyty, na której został przepisany wraz z końcową datą wykorzystania recepty.
5. Medicine_dict
Kolumny: MedicineID (klucz główny), Medicine_name, Acive_substance, Description
Tabela jest słownikiem dotyczącym leków, zapisujemy unikalny numer leku wraz z nazwą.
Dodatkowo możliwe jest dodanie nazwy substancji aktywnej oraz krótkiego opisu leku.
6. Service_dict
Kolumny: ServiceID (klucz główny), Service_name, Price
Tabela jest słownikiem dotyczącym oferowanych usług medycznych. Zapisujemy unikalny
numer id, nazwę usługi oraz cenę. Cena jest zapisywana z użyciem typu danych money. Ten
typ w kolumnie służy do przechowywania wartości pieniężnych. Jest to specjalny typ danych,
który jest zoptymalizowany pod kątem operacji finansowych. Powodem zastosowania jest
dokładność finansowa, format wyjścia oraz zachowanie jednolitości.
7. Disease_perm_dict
Kolumny: DiseaseID (klucz główny), Disease_name, Descriprion
Tabela jest słownikiem dotyczącym chorób współistniejących u pacjentów. Zapisujemy numer
id choroby, nazwę oraz krótki opis na temat diagnozy.
8. Additional_info_patients
Kolumny: PatientID, DiseaseID, EmployeeID, Additional_info, Additional_infoID (klucz
główny)
Tabela zawiera dodatkowe informacje o pacjentach. Pierwsza kolumna dotyczy numeru id
pacjenta, zapisujemy zdiagnozowane numery choroby, numer pracownika, który
zdiagnozował schorzenie oraz możemy zapisywać więcej informacji w kolumnie
Additional_info. Ostatnia kolumna zapisana w formacie json pozwala na zapisanie zmiennej
długości danych dotyczących dodatkowych informacji, możemy przechowywać dowolną
wielkość liter bez określenia długości teksu.

### Założenia przyjęte w projekcie:
1. Każdy pracownik placówki może przepisywać leki pacjentom.
2. Tabela z dodatkowymi informacjami dotyczy zdiagnozowanych chorób.
3. Nie na każdej wizycie musi być przepisany lek.
4. Czas wizyty nie jest z góry określony, notujemy czas rozpoczęcia wizyty.
5. Każda usługa medyczna jest płatna.
6. Pacjent nie ma stałego lekarza, pracownik przypisywany jest tylko na wizytę.
7. Zapisujemy datę zakończenia ważności recepty.
8. Numer PESEL kończący się na cyfrę parzystą oznacza kobietę, na cyfrę nieparzystą oznacza
mężczyznę.
9. W opisach słowo lekarz jak i pracownik są stosowane zamiennie.

## Skrypt - wstawianie rekordów
Do uzupełnienia danych stworzony został skrypt **fake_data.sql** na wstawianie 5-7 rekordów do każdej z tabeli w bazie.
Przykładowo dla tabeli Employees uzupełnianie wierszy odbywa się w następujący sposób:

```
INSERT INTO Employees (EmployeeID, Employee_firstname, Employee_lastname, Title, Phone_number)
VALUES 
    (1, 'Jan', 'Kowalczyk', 'Specjalista medycyny rodzinnej', '873948125'),
    (2, 'Piotr', 'Nowak', 'Stomatolog', '790643011'),
    (3, 'Katarzyna', 'Kasia', 'Położna', '890765231'),
    (4, 'Martyna', 'Wolska', 'Pielęgniarka', '456391293'),
    (5, 'Bożena', 'Dąbrowska', 'Pediatra', '456317843'),
    (6, 'Helena', 'Jaroniewska', 'Specjalista medycyny rodzinnej', '984293451');
```

## Skrypt - transakcja na przetwarzanie danych
W skrypcie **transaction.sql** została utworzona jedna przykładowa transakcja, dotycząca zmiany cen usług, podwyżkę ceny konsultacji oraz obniżenie ceny leczenia kanałowego. 

## Skrypt - tworzenie indeksów w bazie
Skrypt **indexes.sql** został utworzony w celu utworzenia niezbędnych indeksów w całej bazie. W każdej tabeli może występować jeden indeks klastrowany, zostały one utworzone przy konstrukcji kluczy głównych dla wszystkich tabel. 
Przykład utworzenia indeksów nieklastrowanych dla tabeli Employess.

```
CREATE NONCLUSTERED INDEX i_emp_2 on Employees(Employee_firstname)
CREATE NONCLUSTERED INDEX i_emp_3 on Employees(Employee_lastname)
```

### Skrypt - procedura składowana
W skrypcie **stored_procedure.sql** została zapisana procedura składowana, która ma na celu ułatwienie funkcjonowania przychodni. Procedura po podaniu numeru id pacjenta ma na celu podanie: imienia, nazwiska, wieku oraz liczby lat zarejestrowania w przychodni dla pacjenta oraz imienia lekarza i nazwiska lekarza przypisanego do pacjenta w tabeli Additional_info_patients. Jeśli w tabeli Additional_info_patients nie pojawia się przypisany lekarz, to dostaniemy brak zapisu przy imieniu i nazwisku lekarza.
