CREATE TABLE faktury (
    id_faktury         NUMBER(3) NOT NULL,
    data_faktury       DATE NOT NULL,
    wartosc_faktury    NUMBER(8,2) NOT NULL,
    termin_platnosci   DATE NOT NULL,
    id_klienta         NUMBER(3) NOT NULL
);

ALTER TABLE faktury ADD CONSTRAINT faktury_pk PRIMARY KEY ( id_faktury );

CREATE TABLE faktury_pozycje (
    id_faktury    NUMBER(3) NOT NULL,
    pozycja       NUMBER(2) NOT NULL,
    liczba        NUMBER(2) NOT NULL,
    cena_zakupu   NUMBER(8,2) NOT NULL,
    id_produktu   NUMBER(3) NOT NULL
);

ALTER TABLE faktury_pozycje ADD CONSTRAINT faktury_pozycje_pk PRIMARY KEY ( pozycja,
id_faktury );

CREATE TABLE grupy_produktowe (
    id_grupy_produktowej      NUMBER(2) NOT NULL,
    nazwa_grupy_produktowej   VARCHAR2(30) NOT NULL
);

ALTER TABLE grupy_produktowe ADD CONSTRAINT grupy_produktowe_pk PRIMARY KEY ( id_grupy_produktowej );

CREATE TABLE grupy_wiekowe (
    id_grupy_wiekowej      NUMBER(2) NOT NULL,
    nazwa_grupy_wiekowej   VARCHAR2(20) NOT NULL
);

ALTER TABLE grupy_wiekowe ADD CONSTRAINT grupy_wiekowe_pk PRIMARY KEY ( id_grupy_wiekowej );

CREATE TABLE klienci (
    id_klienta             NUMBER(3) NOT NULL,
    imie_klienta           VARCHAR2(25) NOT NULL,
    nazwisko_klienta       VARCHAR2(35) NOT NULL,
    plec_klienta           VARCHAR2(5) NOT NULL,
    rok_urodzenia          NUMBER(4) NOT NULL,
    e_mail_klienta         VARCHAR2(30),
    telefon_klienta        NUMBER(9) NOT NULL,
    ulica_klienta          VARCHAR2(20) NOT NULL,
    numer_domu_klienta     NUMBER(4) NOT NULL,
    numer_lokalu_klienta   NUMBER(4),
    kod_pocztowy_klienta   VARCHAR2(20) NOT NULL,
    miasto_klienta         VARCHAR2(30) NOT NULL,
    id_grupy_wiekowej      NUMBER(2) NOT NULL
);

ALTER TABLE klienci ADD CONSTRAINT klienci_pk PRIMARY KEY ( id_klienta );

CREATE TABLE producenci (
    id_producenta             NUMBER(3) NOT NULL,
    nazwa_producenta          VARCHAR2(20) NOT NULL,
    e_mail_producenta         VARCHAR2(30),
    telefon_producenta        NUMBER(9) NOT NULL,
    ulica_producenta          VARCHAR2(20) NOT NULL,
    numer_domu_producenta     NUMBER(4) NOT NULL,
    numer_lokalu_producenta   NUMBER(4),
    kod_pocztowy_producenta   VARCHAR2(20) NOT NULL,
    miasto_producenta         VARCHAR2(30) NOT NULL
);

ALTER TABLE producenci ADD CONSTRAINT producenci_pk PRIMARY KEY ( id_producenta );

CREATE TABLE produkty (
    id_produktu            NUMBER(3) NOT NULL,
    nazwa_produktu         VARCHAR2(20) NOT NULL,
	model_produktu         VARCHAR2(30) NOT NULL,
    cena_produktu          NUMBER(8,2) NOT NULL,
    ilosc_produktu         NUMBER(4) NOT NULL,
    id_producenta          NUMBER(3) NOT NULL,
    id_grupy_produktowej   NUMBER(2) NOT NULL
);

ALTER TABLE produkty ADD CONSTRAINT produkty_pk PRIMARY KEY ( id_produktu );

ALTER TABLE faktury_pozycje
    ADD CONSTRAINT faktury_faktury_pozycje_fk FOREIGN KEY ( id_faktury )
        REFERENCES faktury ( id_faktury );

ALTER TABLE produkty
    ADD CONSTRAINT grupy_produktowe_produkty_fk FOREIGN KEY ( id_grupy_produktowej )
        REFERENCES grupy_produktowe ( id_grupy_produktowej );

ALTER TABLE klienci
    ADD CONSTRAINT grupy_wiekowe_klienci_fk FOREIGN KEY ( id_grupy_wiekowej )
        REFERENCES grupy_wiekowe ( id_grupy_wiekowej );

ALTER TABLE faktury
    ADD CONSTRAINT klienci_faktury_fk FOREIGN KEY ( id_klienta )
        REFERENCES klienci ( id_klienta );

ALTER TABLE produkty
    ADD CONSTRAINT producenci_produkty_fk FOREIGN KEY ( id_producenta )
        REFERENCES producenci ( id_producenta );

ALTER TABLE faktury_pozycje
    ADD CONSTRAINT produkty_faktury_pozycje_fk FOREIGN KEY ( id_produktu )
        REFERENCES produkty ( id_produktu );

		
		
		
		
		
		
CREATE SEQUENCE PRODUCENCI_SEQ MINVALUE 1 MAXVALUE 99 INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER PRODUCENCI_TRIG 
BEFORE INSERT ON PRODUCENCI 
FOR EACH ROW 
BEGIN
  :new.Id_Producenta := Producenci_seq.nextval;
END;
/
CREATE SEQUENCE GRUPY_PRODUKTOWE_SEQ MINVALUE 1 MAXVALUE 99 INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER GRUPY_PRODUKTOWE_TRIG 
BEFORE INSERT ON GRUPY_PRODUKTOWE 
FOR EACH ROW 
BEGIN
  :new.Id_Grupy_Produktowej := Grupy_Produktowe_seq.nextval;
END;
/
CREATE SEQUENCE PRODUKTY_SEQ MINVALUE 1 MAXVALUE 999 INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER PRODUKTY_TRIG 
BEFORE INSERT ON PRODUKTY 
FOR EACH ROW 
BEGIN
  :new.Id_Produktu :=Produkty_seq.nextval;
END;
/
CREATE SEQUENCE FAKTURY_SEQ MINVALUE 1 MAXVALUE 999 INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER FAKTURY_TRIG 
BEFORE INSERT ON FAKTURY 
FOR EACH ROW 
BEGIN
  :new.Id_Faktury :=Faktury_seq.nextval;
END;
/
CREATE SEQUENCE GRUPY_WIEKOWE_SEQ MINVALUE 1 MAXVALUE 99 INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER GRUPY_WIEKOWE_TRIG 
BEFORE INSERT ON GRUPY_WIEKOWE 
FOR EACH ROW 
BEGIN
  :new.Id_Grupy_Wiekowej :=Grupy_Wiekowe_seq.nextval;
END;
/
CREATE SEQUENCE KLIENCI_SEQ MINVALUE 1 MAXVALUE 999 INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER KLIENCI_TRIG 
BEFORE INSERT ON KLIENCI 
FOR EACH ROW 
BEGIN
  :new.Id_Klienta :=Klienci_seq.nextval;
END;
/

INSERT INTO PRODUCENCI (NAZWA_PRODUCENTA,E_MAIL_PRODUCENTA,TELEFON_PRODUCENTA, 
ULICA_PRODUCENTA, NUMER_DOMU_PRODUCENTA, NUMER_LOKALU_PRODUCENTA, KOD_POCZTOWY_PRODUCENTA, MIASTO_PRODUCENTA) 
select 'Samsung','samsung@poczta.pl',767424245,'Rumiankowa',129,45,'00-003','Warszawa' from dual union all 
select 'Sony','sony@poczta.pl',936482628,'Maslana',2034,100,'00-122','Warszawa' from dual union all 
select 'Aeg','aeg@poczta.pl',836846895,'Miodowa',390,765,'13-353','Krakow' from dual union all 
select 'Siemens','siemens@poczta.pl',164820475,'Jagodowa',674,9,'67-100','Gdansk' from dual union all
select 'Blaupunkt','blaupunkt@poczta.pl',386409864,'Rozana',921,765,'71-923','Wroclaw' from dual union all 
select 'LG','lg@poczta.pl',124364876,'Parkowa',235,3,'90-856','Gdynia' from dual union all 
select 'Motorola','motorola@poczta.pl',745907123,'Lesna',30,10,'71-543','Warszawa' from dual union all 
select 'Toshiba','toshiba@poczta.pl',103648192,'Sloneczna',12,1,'14-090','Rzeszow' from dual union all 
select 'Grundig','grundig@poczta.pl',534098174,'Jesienna',513,102,'29-501','Szczecin' from dual union all 
select 'Philips','philips@poczta.pl',836543071,'Wrzosowa',731,49,'73-012','Poznan' from dual union all 
select 'Apple','apple@poczta.pl',938959127,'Gorska',3879,9,'10-600','Lodz' from dual union all 
select 'Panasonic','panasonic@poczta.pl',436034587,'Amarantowa',209,34,'94-485','Warszawa' from dual union all 
select 'Candy','candy@poczta.pl',932427433,'Kwiatowa',827,67,'74-852','Grudziadz' from dual union all 
select 'Huawei','huawei@poczta.pl',387654576,'Wesola',30,245,'86-003','Inowroclaw' from dual union all 
select 'Htc','htc@poczta.pl',385032143,'Magiczna',39,8,'85-103','Bydgoszcz' from dual union all 
select 'Hp','hp@poczta.pl',896565675,'Polna',3876,34,'76-346','Warszawa' from dual union all 
select 'Lenovo','lenovo@poczta.pl',766434366,'Botaniczna',4,8,'23-763','Krakow' from dual union all 
select 'Canon','canon@poczta.pl',345366659,'Osadowa',986,123,'00-123','Wroclaw' from dual union all 
select 'Nikon','nikon@poczta.pl',875423456,'Ogrodowa',564,9,'54-963','Radom' from dual union all 
select 'Kodak','kodak@poczta.pl',376756467,'Kolejowa',435,834,'54-342','Gdansk' from dual union all 
select 'EA SPORTS','easports@poczta.pl',457876767,'Durszlakowa',12,1,'23-100','Warszawa' from dual union all 
select 'Amica','amica@poczta.pl',897454534,'Piaskowa',902,7,'06-140','Lublin' from dual union all 
select 'Bosch','bosch@poczta.pl',209331912,'Kamienna',5,6,'89-410','Gdynia' from dual union all 
select 'Beko','beko@poczta.pl',987643451,'Dojazdowa',15,4,'23-431','Czestochowa' from dual union all 
select 'Electrolux','electrolux@poczta.pl',786664123,'Morska',389,2,'87-147','Szczecin' from dual;

INSERT INTO GRUPY_PRODUKTOWE (NAZWA_GRUPY_PRODUKTOWEJ) 
select 'RTV i Telewizory' from dual union all 
select 'Komputery i Tablety' from dual union all 
select 'Foto i Kamery' from dual union all 
select 'Telefony i Smartfony' from dual union all 
select 'Konsole i Gry' from dual union all 
select 'AGD Duze' from dual union all 
select 'AGD Male' from dual;

INSERT INTO PRODUKTY (NAZWA_PRODUKTU,MODEL_PRODUKTU,CENA_PRODUKTU,ILOSC_PRODUKTU,ID_PRODUCENTA,ID_GRUPY_PRODUKTOWEJ) 
select 'Telewizor','ASD-6587',2500,300,1,1 from dual union all 
select 'Telewizor','GFH-8712',1500,150,9,1 from dual union all 
select 'Telewizor','JUSD-76',1000,100,12,1 from dual union all 
select 'Telewizor','WE-6543',1700,125,10,1 from dual union all 
select 'Telewizor','JCX-3890',800,180,5,1 from dual union all 
select 'Telewizor','UIOP-8',1100,90,6,1 from dual union all 
select 'Telewizor','REWD-143',900,60,8,1 from dual union all 
select 'Telewizor','CXZ-7954',1600,140,2,1 from dual union all 
select 'Telewizor','IOY-91',1350,70,1,1 from dual union all 
select 'Telewizor','AAC-1322',1600,85,1,1 from dual union all 
select 'Telewizor','FGD-476764',1270,100,2,1 from dual union all 
select 'Telewizor','ADSJ-23',900,80,6,1 from dual union all 
select 'Telewizor','OS-765',760,50,5,1 from dual union all 
select 'Projektor','L-34',1500,40,1,1 from dual union all 
select 'Projektor','H-02',1200,45,3,1 from dual union all 
select 'Projektor','TY-34',1700,60,1,1 from dual union all 
select 'Projektor','A-8754',1100,35,4,1 from dual union all 
select 'Projektor','IU-7445',1900,90,1,1 from dual union all 
select 'Zestaw kina domowego','ER-33334',2899,30,2,1 from dual union all 
select 'Zestaw kina domowego','UUG-647',2500,50,1,1 from dual union all 
select 'Zestaw kina domowego','W-98',3500,40,12,1 from dual union all 
select 'Zestaw kina domowego','OA-8978',2200,35,6,1 from dual union all 
select 'Zestaw kina domowego','UI-9595',1800,38,2,1 from dual union all 
select 'Laptop','OJFYUFU',2000,50,16,2 from dual union all 
select 'Laptop','FTFKG',2500,45,17,2 from dual union all 
select 'Laptop','DRHDR',3000,55,16,2 from dual union all 
select 'Laptop','GFGGHGH',2300,30,11,2 from dual union all 
select 'Laptop','POOPUI',2600,50,1,2 from dual union all 
select 'Laptop','DYUFGDG',1600,58,8,2 from dual union all 
select 'Laptop','SDAFES',2450,45,16,2 from dual union all 
select 'Laptop','POPFJMN',1899,48,1,2 from dual union all 
select 'Laptop','ZDGHNK',1500,60,2,2 from dual union all 
select 'Laptop','GYUTFD',3000,54,2,2 from dual union all 
select 'Monitor','3-DSD',500,30,1,2 from dual union all 
select 'Monitor','8-JF',650,35,2,2 from dual union all 
select 'Tablet','JKLJL',1800,200,6,2 from dual union all 
select 'Tablet','AASSDKL',1900,220,7,2 from dual union all 
select 'Tablet','869VEVD',1500,150,6,2 from dual union all 
select 'Tablet','87T8G8',1200,100,15,2 from dual union all 
select 'Tablet','D7V87D',1450,160,15,2 from dual union all 
select 'Tablet','56CED6',1299,90,2,2 from dual union all 
select 'Tablet','456BNGD',900,90,5,2 from dual union all 
select 'Tablet','79V46WX3',2100,140,1,2 from dual union all 
select 'Kamera','85456',300,70,12,3 from dual union all 
select 'Kamera','78563',2500,100,1,3 from dual union all 
select 'Kamera','39726',1300,65,10,3 from dual union all 
select 'Kamera','3536367',1400,90,11,3 from dual union all 
select 'Kamera','6544336',900,49,3,3 from dual union all 
select 'Kamera','34768768',1800,80,4,3 from dual union all 
select 'Dron','SYTX',3000,30,1,3 from dual union all 
select 'Dron','IOJ',3500,50,17,3 from dual union all 
select 'Aparat cyfrowy','SYTX',3000,60,18,3 from dual union all 
select 'Aparat cyfrowy','GIDD',2000,45,19,3 from dual union all 
select 'Aparat cyfrowy','EQQW',1700,90,20,3 from dual union all 
select 'Aparat cyfrowy','DRT',1900,47,19,3 from dual union all 
select 'Aparat cyfrowy','YUGYU',2300,70,19,3 from dual union all 
select 'Aparat cyfrowy','SFD',2550,46,20,3 from dual union all 
select 'Aparat cyfrowy','OIJO',1900,65,18,3 from dual union all 
select 'Telefon stacjonarny','34J3J4',500,40,1,4 from dual union all 
select 'Telefon stacjonarny','7G6F68',900,45,2,4 from dual union all 
select 'Telefon stacjonarny','5D47',850,49,9,4 from dual union all 
select 'Smartfon','GVYGD',2300,150,1,4 from dual union all 
select 'Smartfon','OJJHS',1800,90,7,4 from dual union all 
select 'Smartfon','JIOJDR',1400,100,11,4 from dual union all 
select 'Smartfon','5UCR55',1999,89,2,4 from dual union all 
select 'Smartfon','5C5CC7',900,50,4,4 from dual union all 
select 'Smartfon','8D48D4',1180,40,10,4 from dual union all 
select 'Smartfon','TR609',900,70,8,4 from dual union all 
select 'Smartfon','346C6V',2100,110,1,4 from dual union all 
select 'Smartfon','34EDRT',1760,85,2,4 from dual union all 
select 'Smartfon','3232AS3',2400,40,11,4 from dual union all 
select 'Smartfon','UIUGYF',1400,100,17,4 from dual union all 
select 'Smartfon','DRTF89',1250,60,15,4 from dual union all 
select 'Smartfon','RFDTR',1330,54,9,4 from dual union all 
select 'Smartfon','GYUOLK',1220,120,1,4 from dual union all 
select 'Smartfon','9UYHED',800,35,6,4 from dual union all 
select 'Smartwatch','UYGU',1500,30,1,4 from dual union all 
select 'Smartwatch','WSTUI',1470,45,11,4 from dual union all 
select 'Konsola','85670',1800,90,2,5 from dual union all 
select 'Konsola','23452',1770,120,2,5 from dual union all 
select 'Konsola','9776',2200,130,2,5 from dual union all 
select 'FIFA 15','HJTUYR',150,180,21,5 from dual union all 
select 'FIFA 18','TRDRTD',200,300,21,5 from dual union all 
select 'NHL 17','UIHGGP',130,100,21,5 from dual union all 
select 'NBA 18','67VT76',190,300,21,5 from dual union all 
select 'Pralka','785642',2400,60,1,6 from dual union all 
select 'Pralka','74523',2300,50,23,6 from dual union all 
select 'Pralka','987754',1800,45,22,6 from dual union all 
select 'Pralka','24565',1750,90,1,6 from dual union all 
select 'Suszarka','LHDPDFD',1300,60,24,6 from dual union all 
select 'Suszarka','POUIYTY',1530,67,24,6 from dual union all 
select 'Suszarka','QWSQOSO',1900,100,25,6 from dual union all 
select 'Suszarka','QAZES',1900,62,1,6 from dual union all 
select 'Lodowka','9876FJ',800,49,25,6 from dual union all 
select 'Lodowka','ZXRT7G',1300,54,24,6 from dual union all 
select 'Lodowka','4V6RY',1230,67,1,6 from dual union all 
select 'Lodowka','23MNE9N3',1600,80,22,6 from dual union all 
select 'Lodowka','73BEB',1100,90,23,6 from dual union all 
select 'Zmywarka','3CVBNK',1000,50,23,6 from dual union all 
select 'Zmywarka','98NDV',1300,53,25,6 from dual union all 
select 'Zmywarka','CFYHHIO',900,58,22,6 from dual union all 
select 'Zmywarka','IUYUG',1250,50,23,6 from dual union all 
select 'Zmywarka','09N0N',1000,40,24,6 from dual union all 
select 'Odkurzacz','78545',900,90,1,7 from dual union all 
select 'Odkurzacz','7GF878',1100,100,25,7 from dual union all 
select 'Odkurzacz','X54Z5',800,120,25,7 from dual union all 
select 'Odkurzacz','7FXX56SR',1400,87,4,7 from dual union all 
select 'Odkurzacz','2XZ55',1050,50,4,7 from dual union all 
select 'Odkurzacz','2WSES',1400,120,1,7 from dual union all 
select 'Zelazko','SDASD',300,120,1,7 from dual union all 
select 'Zelazko','4CVB7H',250,70,4,7 from dual union all 
select 'Zelazko','34SD5F',600,60,4,7 from dual union all 
select 'Zelazko','37E9WBY',800,40,10,7 from dual union all 
select 'Zelazko','92WN0S',1000,90,10,7 from dual union all 
select 'Blender','2WXW54',400,80,1,7 from dual union all 
select 'Blender','89N9B',450,60,10,7 from dual union all 
select 'Blender','78G9',200,80,5,7 from dual union all 
select 'Golarka','78VC689',200,130,9,7 from dual union all 
select 'Golarka','87TVZW45',230,110,12,7 from dual union all 
select 'Mikser','90YGFDTY',400,90,1,7 from dual union all 
select 'Mikser','8TGC',450,95,2,7 from dual union all 
select 'Mikser','0N9UWB89',350,80,6,7 from dual;

INSERT INTO GRUPY_WIEKOWE (NAZWA_GRUPY_WIEKOWEJ) 
select '0-10 lat' from dual union all 
select '11-20 lat' from dual union all 
select '21-30 lat' from dual union all 
select '31-40 lat' from dual union all 
select '41-50 lat' from dual union all 
select '51-60 lat' from dual union all 
select '61-70 lat' from dual union all 
select '71-80 lat' from dual union all 
select '81-90 lat' from dual union all 
select '91-100 lat' from dual;
 
INSERT INTO KLIENCI (IMIE_KLIENTA,NAZWISKO_KLIENTA,PLEC_KLIENTA,ROK_URODZENIA,E_MAIL_KLIENTA,TELEFON_KLIENTA,ULICA_KLIENTA,NUMER_DOMU_KLIENTA,NUMER_LOKALU_KLIENTA,KOD_POCZTOWY_KLIENTA,MIASTO_KLIENTA,ID_GRUPY_WIEKOWEJ) 
select 'Marian','Baryla','M',1985,'baryla@mail.pl',786245245,'Fiolkowa',23,4,'00-234','Warszawa',4 from dual union all 
select 'Sebastian','Watroba','M',1970,'watroba@mail.pl',753432251,'Klonowa',21,1,'10-743','Warszawa',5 from dual union all 
select 'Anna','Palka','K',1973,'palka@mail.pl',897546562,'Koszykowa',345,9,'54-734','Warszawa',5 from dual union all 
select 'Joanna','Czechowska','K',1979,'czechowska@mail.pl',246547856,'Lubelska',987,234,'87-123','Warszawa',4 from dual union all 
select 'Pawel','Wierzba','M',1990,'wierzba@mail.pl',972356768,'Mietowa',32,12,'01-345','Warszawa',3 from dual union all 
select 'Antoni','Ryjak','M',1995,'ryjak@mail.pl',254357686,'Deszczowa',679,78,'23-532','Warszawa',3 from dual union all 
select 'Marcin','Mucha','M',1998,'mucha@mail.pl',768764552,'Drozda',87,1,'75-768','Warszawa',5 from dual union all 
select 'Maria','Pigula','K',1968,'pigula@mail.pl',436769879,'Zelazna',2,1,'64-634','Warszawa',5 from dual union all 
select 'Jozef','Kurowski','M',1950,'kurowski@mail.pl',345646558,'Jelenia',1,1,'87-234','Warszawa',7 from dual union all 
select 'Irena','Mroz','K',1929,'mroz@mail.pl',764464545,'Ognista',53,87,'23-987','Warszawa',9 from dual union all 
select 'Agata','Rogowicz','K',2009,'rogowicz@mail.pl',232242433,'Swierkowa',89,123,'00-234','Warszawa',1 from dual union all 
select 'Roman','Guzowski','M',1926,'guzowski@mail.pl',347677887,'Rolnicza',12,9,'78-183','Warszawa',10 from dual union all 
select 'Alicja','Wolak','K',1956,'wolak@mail.pl',839274829,'Wodna',1,76,'65-654','Warszawa',7 from dual union all 
select 'Adam','Chojnowski','M',1961,'chojnowski@mail.pl',818182882,'Kacza',17,178,'32-423','Warszawa',6 from dual union all 
select 'Jan','Ciechocinski','M',1976,'ciechocinski@mail.pl',283892893,'Zwirkowa',54,9,'87-384','Warszawa',5 from dual union all 
select 'Krzysztof','Baranowski','M',1979,'baranowski@mail.pl',828201291,'Blotna',12,81,'00-914','Warszawa',4 from dual union all 
select 'Krystyna','Wiatrowicz','K',1990,'wiatrowicz@mail.pl',781782172,'Strumyczkowa',8,4,'81-893','Warszawa',3 from dual union all 
select 'Bogdan','Jasinski','M',1963,'jasinski@mail.pl',893891221,'Muzyczna',86,61,'23-975','Warszawa',6 from dual union all 
select 'Katarzyna','Kurkowska','K',1993,'kurkowska@mail.pl',786136121,'Chabrowa',781,321,'82-343','Warszawa',3 from dual union all 
select 'Zenon','Solski','M',1947,'solski@mail.pl',768453456,'Runowska',916,3,'52-864','Warszawa',8 from dual union all 
select 'Barbara','Krakowiak','K',1925,'krakowiak@mail.pl',893762621,'Zlota',372,81,'94-423','Warszawa',9 from dual union all 
select 'Rafal','Wojcik','M',1965,'wojcik@mail.pl',896256689,'Konwaliowa',64,3,'07-129','Warszawa',6 from dual union all 
select 'Melania','Szymanska','K',2010,'szymanska@mail.pl',894734561,'Bambusowa',2,5,'92-375','Warszawa',1 from dual union all 
select 'Michal','Kozlowski','M',1940,'kozlowski@mail.pl',132727323,'Kremowa',27,735,'94-445','Warszawa',8 from dual union all 
select 'Natalia','Mazur','K',2006,'mazur@mail.pl',563473783,'Orzechowa',83,543,'67-564','Warszawa',2 from dual union all 
select 'Wiktoria','Krawczyk','K',1949,'krawczyk@mail.pl',768376373,'Zajecza',823,634,'93-293','Warszawa',7 from dual union all 
select 'Igor',' Nowak','M',1986,'nowak@mail.pl',789481289,'Wspolna',7,1,'75-153','Warszawa',4 from dual union all 
select 'Roman','Jankowski','M',1953,'jankowski@mail.pl',892189122,'Marszalkowska',226,153,'73-876','Warszawa',7 from dual union all 
select 'Justyna','Pawlak','K',1987,'pawlak@mail.pl',238923893,'Fantazyjna',5,5,'33-542','Warszawa',4 from dual union all 
select 'Marta','Sikorska','K',2013,'sikorska@mail.pl',278626062,'Radarowa',982,312,'00-234','Warszawa',1 from dual union all 
select 'Filip','Duda','M',1979,'duda@mail.pl',367687897,'Wilenska',76,123,'00-234','Warszawa',4 from dual union all 
select 'Jerzy','Wilk','M',1963,'wilk@mail.pl',478866868,'Brzozowa',73,23,'34-643','Warszawa',6 from dual union all 
select 'Hubert','Urbanski','M',1972,'urbanski@mail.pl',363893789,'Nowoursynowska',73,12,'00-354','Warszawa',5 from dual union all 
select 'Renata','Makowska','K',1960,'makowska@mail.pl',789768562,'Czekoladowa',8,234,'42-755','Warszawa',6 from dual union all 
select 'Maciej','Czerwinski','M',2003,'czerwinski@mail.pl',894523893,'Meksykanska',42,2,'87-565','Warszawa',2 from dual union all 
select 'Anastazja','Kozak','K',1978,'kozak@mail.pl',785443567,'Malinowa',454,231,'38-545','Warszawa',4 from dual union all 
select 'Kornelia','Zak','K',1994,'zak@mail.pl',897233782,'Koscielna',345,43,'54-255','Warszawa',3 from dual union all 
select 'Maja','Kot','K',2089,'kot@mail.pl',765676722,'Blokowa',13,1345,'65-132','Warszawa',3 from dual union all 
select 'Zofia','Krupa','K',1986,'krupa@mail.pl',738612381,'Zabkowska',53,675,'12-876','Warszawa',4 from dual union all 
select 'Mieczyslaw','Smiech','M',1969,'smiech@mail.pl',891289121,'Gruba',876,123,'54-123','Warszawa',5 from dual union all 
select 'Aniela','Tomaszewska','K',1997,'tomaszewska@mail.pl',322242342,'Uranowa',234,45,'98-768','Warszawa',3 from dual union all 
select 'Slawomir','Plot','M',1981,'plot@mail.pl',893389221,'Topolowa',232,126,'66-238','Warszawa',4 from dual union all 
select 'Marlena','Kruk','K',1944,'kruk@mail.pl',893762762,'Pszenna',213,754,'13-764','Warszawa',8 from dual union all 
select 'Lukasz','Sowa','M',1977,'sowa@mail.pl',467488675,'Traugutta',212,1,'00-004','Warszawa',5 from dual union all 
select 'Szymon','Piasecki','M',1993,'piasecki@mail.pl',347689899,'Morska',63,5,'85-145','Warszawa',3 from dual union all 
select 'Zygmunt','Sosnowski','M',1936,'sosnowski@mail.pl',625276322,'Roskoszna',2,9,'00-234','Warszawa',9 from dual union all 
select 'Stanislaw','Slomkowski','M',1944,'slomkowski@mail.pl',223563768,'Czysta',861,41,'00-234','Warszawa',8 from dual union all 
select 'Janina','Sofa','K',1938,'sofa@mail.pl',324527678,'Krzykliwa',476,8,'76-123','Warszawa',8 from dual union all 
select 'Albert','Wronowicz','M',1966,'wronowicz@mail.pl',382429231,'Lustrzana',712,76,'78-123','Warszawa',6 from dual union all 
select 'Andrzej','Sobolewski','M',1975,'sobolewski@mail.pl',345456781,'Mleczna',987,1,'00-234','Warszawa',5 from dual union all 
select 'Ryszard','Pisowski','M',1999,'pisowski@mail.pl',346676878,'Ruska',22,4,'87-876','Warszawa',2 from dual; 

 
create or replace function data_faktury_fun(nr klienci.id_klienta%type) return date as 

rok klienci.rok_urodzenia%type;
dzien number;
miesiac number;
data1 date;

begin 
select rok_urodzenia+round(dbms_random.value(18,35),0) into rok from klienci where id_klienta=nr;
if rok>2017 
then 
rok:=2017;
end if;
miesiac:=round(dbms_random.value(1,12),0);
if miesiac=2
then 
dzien:=round(dbms_random.value(1,28),0);
else 
dzien:=round(dbms_random.value(1,30),0);
end if;

data1:=to_date(to_char(rok||'/'||miesiac||'/'||dzien));
return data1;

end;
/
create or replace function id_klienta_fun return number as 

liczba1 klienci.id_klienta%type;
liczba2 klienci.id_klienta%type;

begin

select min(id_klienta), max(id_klienta) into liczba1,liczba2 from klienci;
return round(dbms_random.value(liczba1,liczba2),0);

end;
/
create or replace function id_produktu_fun return number as 

liczba1 produkty.id_produktu%type;
liczba2 produkty.id_produktu%type;

begin

select min(id_produktu), max(id_produktu) into liczba1,liczba2 from produkty;
return round(dbms_random.value(liczba1,liczba2),0);

end;
/

create or replace procedure generator (ile_razy number default 1, sek number default 0) as 

pozycja faktury_pozycje.pozycja%type;
wartosc_f faktury.wartosc_faktury%type;
liczba faktury_pozycje.liczba%type;
liczba1 number(4);
nr_f faktury.id_faktury%type;
nr_p produkty.id_produktu%type;
cena_p faktury_pozycje.cena_zakupu%type;
data_f date;
id_k klienci.id_klienta%type;
j number(4);
ile_sek number(20,10);

begin

if sek!=0 
then 
ile_sek:=sek/ile_razy; --opoznienie na kazdy nawrot petli
end if;

for i in 1..ile_razy --ile transakcji wygenerowac
loop
if sek!=0
then
dbms_lock.sleep(ile_sek);--opoznienie
end if;

wartosc_f:=0;
id_k:=id_klienta_fun; --losuje id klienta
data_f:=data_faktury_fun(id_k); --losuje date faktury

insert into faktury (data_faktury,wartosc_faktury,termin_platnosci,id_klienta) 
values (data_f,0,data_f+14,id_k);

pozycja:=round(dbms_random.value(1,5),0); --ile produktow kupi klient
nr_f:=faktury_seq.currval;
j:=1;


while j<=pozycja --tyle razy ile klient kupil produktow
loop

loop
liczba:=round(dbms_random.value(1,5),0); --ile sztuk produktu
nr_p:=id_produktu_fun;

select ilosc_produktu into liczba1 from produkty where id_produktu=nr_p;

exit when liczba1>=liczba; --jesli na magazynie jest wiecej niz chce klient
end loop;

select round((cena_produktu*1.1),0) into cena_p from produkty where id_produktu=nr_p;
--pobieram cene

insert into faktury_pozycje values (nr_f,j,liczba,cena_p,nr_p);
update produkty set ilosc_produktu=ilosc_produktu-liczba where id_produktu=nr_p;


wartosc_f:=round(wartosc_f+(liczba*cena_p),0);--zliczam wartosc faktury
j:=j+1;
end loop;

update faktury set wartosc_faktury = wartosc_f where id_faktury=nr_f;
--wkladam do bazy wartosc faktury

end loop;
end;
/
create or replace view Zestawienie_sprzedazy as 
select nazwa_producenta "Producent",nazwa_produktu "Produkt", 
model_produktu "Model",p.id_produktu "Id produktu",
sum(liczba) "Suma w danym roku", extract(year from data_faktury) "Rok"
from producenci pp,faktury_pozycje f, faktury ff, produkty p 
where f.id_faktury=ff.id_faktury and f.id_produktu=p.id_produktu and
pp.id_producenta=p.id_producenta group by p.id_produktu,nazwa_produktu,
model_produktu,nazwa_producenta,extract(year from data_faktury) 
order by "Rok" desc,"Suma w danym roku"desc,"Id produktu";
/
create or replace view Stan_magazynu as 
select nazwa_producenta "Producent",nazwa_produktu "Produkt",id_produktu "Id produktu",  
model_produktu "Model", ilosc_produktu "Ilosc"  
from produkty p, producenci pr where p.id_producenta=pr.id_producenta order by 
id_produktu;
/
create or replace view Zyski as 
select extract(year from data_faktury) "Rok",extract(month from data_faktury) "Miesiac", 
sum((liczba * cena_zakupu) - (liczba* cena_produktu)) "Zysk" 
from faktury_pozycje f,produkty p,faktury ff where 
f.id_produktu=p.id_produktu and ff.id_faktury=f.id_faktury 
group by extract(year from data_faktury),extract(month from data_faktury) 
order by "Rok" desc,"Miesiac";

create or replace view Zestawienie_sprzedazy_krzyzowo as 
select p.id_produktu,nazwa_producenta,nazwa_produktu,model_produktu, 
sum(case when (extract(year from data_faktury)) between 1918 and 1948 then liczba else 0 end)as "1938-1948",
sum(case when (extract(year from data_faktury)) between 1949 and 1958 then liczba else 0 end)as "1949-1958",
sum(case when (extract(year from data_faktury)) between 1959 and 1968 then liczba else 0 end)as "1959-1968",
sum(case when (extract(year from data_faktury)) between 1969 and 1978 then liczba else 0 end)as "1969-1978",
sum(case when (extract(year from data_faktury)) between 1979 and 1988 then liczba else 0 end)as "1979-1988",
sum(case when (extract(year from data_faktury)) between 1989 and 1998 then liczba else 0 end)as "1989-1998",
sum(case when (extract(year from data_faktury)) between 1999 and 2008 then liczba else 0 end)as "1999-2008",
sum(case when (extract(year from data_faktury)) between 2009 and 2018 then liczba else 0 end)as "2009-2018",
sum(Liczba) as "Suma"
from faktury_pozycje fa, faktury f,produkty p,producenci pp where p.id_producenta=pp.id_producenta and
fa.id_faktury=f.id_faktury and p.id_produktu=fa.id_produktu 
group by p.id_produktu,nazwa_produktu,model_produktu,nazwa_producenta 

union

select null,null,null,'Razem',
sum(case when (extract(year from data_faktury)) between 1918 and 1948 then liczba else 0 end)as "1938-1948",
sum(case when (extract(year from data_faktury)) between 1949 and 1958 then liczba else 0 end)as "1949-1958",
sum(case when (extract(year from data_faktury)) between 1959 and 1968 then liczba else 0 end)as "1959-1968",
sum(case when (extract(year from data_faktury)) between 1969 and 1978 then liczba else 0 end)as "1969-1978",
sum(case when (extract(year from data_faktury)) between 1979 and 1988 then liczba else 0 end)as "1979-1988",
sum(case when (extract(year from data_faktury)) between 1989 and 1998 then liczba else 0 end)as "1989-1998",
sum(case when (extract(year from data_faktury)) between 1999 and 2008 then liczba else 0 end)as "1999-2008",
sum(case when (extract(year from data_faktury)) between 2009 and 2018 then liczba else 0 end)as "2009-2018",
sum(Liczba) as "Suma" from faktury_pozycje fa, faktury f,produkty p where fa.id_faktury=f.id_faktury and p.id_produktu=fa.id_produktu 
group by null,'Razem' order by id_produktu;

 