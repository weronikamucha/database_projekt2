USE Projekt2

BEGIN TRANSACTION Service_Price
-- Przyk�ad Transakcji: Zmiana ceny us�ug (podwy�ka cen konsultacji oraz obni�enie ceny leczenia kana�owego)
UPDATE Service_dict
   SET Price = Price+100
 WHERE Service_name = 'Konsultacja og�lna';

UPDATE Service_dict
   SET Price = Price-100
 WHERE Service_name = 'Leczenie kana�owe';
--SELECT @@TRANCOUNT AS OpenTransactions --sprawdzenie liczby transakcji przed procedur� commit
COMMIT;
--SELECT @@TRANCOUNT AS OpenTransactions --sprawdzenie liczby transakcji po procedurze commit
Select * from Service_dict --sprawdzenie zmian
