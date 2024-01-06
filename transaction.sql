USE Projekt2

BEGIN TRANSACTION Service_Price
-- Przyk³ad Transakcji: Zmiana ceny us³ug (podwy¿ka cen konsultacji oraz obni¿enie ceny leczenia kana³owego)
UPDATE Service_dict
   SET Price = Price+100
 WHERE Service_name = 'Konsultacja ogólna';

UPDATE Service_dict
   SET Price = Price-100
 WHERE Service_name = 'Leczenie kana³owe';
--SELECT @@TRANCOUNT AS OpenTransactions --sprawdzenie liczby transakcji przed procedur¹ commit
COMMIT;
--SELECT @@TRANCOUNT AS OpenTransactions --sprawdzenie liczby transakcji po procedurze commit
Select * from Service_dict --sprawdzenie zmian
