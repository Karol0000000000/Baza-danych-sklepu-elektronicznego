CREATE TABLE faktury (
    id_faktury         NUMERIC(3) NOT NULL,
    data_faktury       DATE NOT NULL,
    wartosc_faktury    NUMERIC(8,2) NOT NULL,
    termin_platnosci   DATE NOT NULL,
    id_klienta         NUMERIC(3) NOT NULL
);

ALTER TABLE faktury ADD CONSTRAINT faktury_pk PRIMARY KEY ( id_faktury );

CREATE TABLE faktury_pozycje (
    id_faktury    NUMERIC(3) NOT NULL,
    pozycja       NUMERIC(2) NOT NULL,
    liczba        NUMERIC(2) NOT NULL,
    cena_zakupu   NUMERIC(8,2) NOT NULL,
    id_produktu   NUMERIC(3) NOT NULL
);

ALTER TABLE faktury_pozycje ADD CONSTRAINT faktury_pozycje_pk PRIMARY KEY ( pozycja,
id_faktury );

CREATE TABLE grupy_produktowe (
    id_grupy_produktowej      NUMERIC(2) NOT NULL,
    nazwa_grupy_produktowej   VARCHAR(30) NOT NULL
);

ALTER TABLE grupy_produktowe ADD CONSTRAINT grupy_produktowe_pk PRIMARY KEY ( id_grupy_produktowej );

CREATE TABLE grupy_wiekowe (
    id_grupy_wiekowej      NUMERIC(2) NOT NULL,
    nazwa_grupy_wiekowej   VARCHAR(20) NOT NULL
);

ALTER TABLE grupy_wiekowe ADD CONSTRAINT grupy_wiekowe_pk PRIMARY KEY ( id_grupy_wiekowej );

CREATE TABLE klienci (
    id_klienta             NUMERIC(3) NOT NULL,
    imie_klienta           VARCHAR(25) NOT NULL,
    nazwisko_klienta       VARCHAR(35) NOT NULL,
    plec_klienta           VARCHAR(5) NOT NULL,
    rok_urodzenia          NUMERIC(4) NOT NULL,
    e_mail_klienta         VARCHAR(30),
    telefon_klienta        NUMERIC(9) NOT NULL,
    ulica_klienta          VARCHAR(20) NOT NULL,
    numer_domu_klienta     NUMERIC(4) NOT NULL,
    numer_lokalu_klienta   NUMERIC(4),
    kod_pocztowy_klienta   VARCHAR(20) NOT NULL,
    miasto_klienta         VARCHAR(30) NOT NULL,
    id_grupy_wiekowej      NUMERIC(2) NOT NULL
);

ALTER TABLE klienci ADD CONSTRAINT klienci_pk PRIMARY KEY ( id_klienta );

CREATE TABLE producenci (
    id_producenta             NUMERIC(3) NOT NULL,
    nazwa_producenta          VARCHAR(20) NOT NULL,
    e_mail_producenta         VARCHAR(30),
    telefon_producenta        NUMERIC(9) NOT NULL,
    ulica_producenta          VARCHAR(20) NOT NULL,
    numer_domu_producenta     NUMERIC(4) NOT NULL,
    numer_lokalu_producenta   NUMERIC(4),
    kod_pocztowy_producenta   VARCHAR(20) NOT NULL,
    miasto_producenta         VARCHAR(30) NOT NULL
);

ALTER TABLE producenci ADD CONSTRAINT producenci_pk PRIMARY KEY ( id_producenta );

CREATE TABLE produkty (
    id_produktu            NUMERIC(3) NOT NULL,
    nazwa_produktu         VARCHAR(20) NOT NULL,
	model_produktu         VARCHAR(30) NOT NULL,
    cena_produktu          NUMERIC(8,2) NOT NULL,
    ilosc_produktu         NUMERIC(4) NOT NULL,
    id_producenta          NUMERIC(3) NOT NULL,
    id_grupy_produktowej   NUMERIC(2) NOT NULL
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

		
		
		
		
		
		
CREATE SEQUENCE PRODUCENCI_SEQ MINVALUE 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER PRODUCENCI_TRIG 
BEFORE INSERT ON PRODUCENCI 
referencing new as nowy  
FOR EACH ROW  
BEGIN
   set nowy.id_producenta=producenci_seq.nextval;

END;

CREATE SEQUENCE GRUPY_PRODUKTOWE_SEQ MINVALUE 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER GRUPY_PRODUKTOWE_TRIG 
BEFORE INSERT ON GRUPY_PRODUKTOWE 
referencing new as nowy 
FOR EACH ROW 
BEGIN
	set nowy.id_grupy_produktowej=Grupy_Produktowe_seq.nextval;
END;

CREATE SEQUENCE PRODUKTY_SEQ MINVALUE 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER PRODUKTY_TRIG 
BEFORE INSERT ON PRODUKTY 
referencing new as nowy 
FOR EACH ROW 
BEGIN
	set nowy.id_produktu=Produkty_seq.nextval;
END;

CREATE SEQUENCE FAKTURY_SEQ MINVALUE 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER FAKTURY_TRIG 
BEFORE INSERT ON FAKTURY 
referencing new as nowy 
FOR EACH ROW 
BEGIN
	set nowy.id_faktury=Faktury_seq.nextval;
END;

CREATE SEQUENCE GRUPY_WIEKOWE_SEQ MINVALUE 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER GRUPY_WIEKOWE_TRIG 
BEFORE INSERT ON GRUPY_WIEKOWE 
referencing new as nowy 
FOR EACH ROW 
BEGIN
	set nowy.id_grupy_wiekowej=Grupy_Wiekowe_seq.nextval;
END;

CREATE SEQUENCE KLIENCI_SEQ MINVALUE 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER KLIENCI_TRIG 
BEFORE INSERT ON KLIENCI 
referencing new as nowy 
FOR EACH ROW 
BEGIN
	set nowy.id_klienta=Klienci_seq.nextval;
END;


INSERT INTO PRODUCENCI (NAZWA_PRODUCENTA,E_MAIL_PRODUCENTA,TELEFON_PRODUCENTA, 
ULICA_PRODUCENTA, NUMER_DOMU_PRODUCENTA, NUMER_LOKALU_PRODUCENTA, KOD_POCZTOWY_PRODUCENTA, MIASTO_PRODUCENTA) VALUES 
('Samsung','samsung@poczta.pl',767424245,'Rumiankowa',129,45,'00-003','Warszawa'),
('Sony','sony@poczta.pl',936482628,'Maslana',2034,100,'00-122','Warszawa'), 
('Aeg','aeg@poczta.pl',836846895,'Miodowa',390,765,'13-353','Krakow'), 
('Siemens','siemens@poczta.pl',164820475,'Jagodowa',674,9,'67-100','Gdansk'),
('Blaupunkt','blaupunkt@poczta.pl',386409864,'Rozana',921,765,'71-923','Wroclaw'),
('LG','lg@poczta.pl',124364876,'Parkowa',235,3,'90-856','Gdynia'), 
('Motorola','motorola@poczta.pl',745907123,'Lesna',30,10,'71-543','Warszawa'),
('Toshiba','toshiba@poczta.pl',103648192,'Sloneczna',12,1,'14-090','Rzeszow'),
('Grundig','grundig@poczta.pl',534098174,'Jesienna',513,102,'29-501','Szczecin'),
('Philips','philips@poczta.pl',836543071,'Wrzosowa',731,49,'73-012','Poznan'),
('Apple','apple@poczta.pl',938959127,'Gorska',3879,9,'10-600','Lodz'), 
('Panasonic','panasonic@poczta.pl',436034587,'Amarantowa',209,34,'94-485','Warszawa'),
('Candy','candy@poczta.pl',932427433,'Kwiatowa',827,67,'74-852','Grudziadz'),
('Huawei','huawei@poczta.pl',387654576,'Wesola',30,245,'86-003','Inowroclaw'),
('Htc','htc@poczta.pl',385032143,'Magiczna',39,8,'85-103','Bydgoszcz'),
('Hp','hp@poczta.pl',896565675,'Polna',3876,34,'76-346','Warszawa'),
('Lenovo','lenovo@poczta.pl',766434366,'Botaniczna',4,8,'23-763','Krakow'),
('Canon','canon@poczta.pl',345366659,'Osadowa',986,123,'00-123','Wroclaw'),
('Nikon','nikon@poczta.pl',875423456,'Ogrodowa',564,9,'54-963','Radom'),
('Kodak','kodak@poczta.pl',376756467,'Kolejowa',435,834,'54-342','Gdansk'),
('EA SPORTS','easports@poczta.pl',457876767,'Durszlakowa',12,1,'23-100','Warszawa'),
('Amica','amica@poczta.pl',897454534,'Piaskowa',902,7,'06-140','Lublin'),
('Bosch','bosch@poczta.pl',209331912,'Kamienna',5,6,'89-410','Gdynia'),
('Beko','beko@poczta.pl',987643451,'Dojazdowa',15,4,'23-431','Czestochowa'),
('Electrolux','electrolux@poczta.pl',786664123,'Morska',389,2,'87-147','Szczecin');

INSERT INTO GRUPY_PRODUKTOWE (NAZWA_GRUPY_PRODUKTOWEJ) VALUES 
('RTV i Telewizory'),
('Komputery i Tablety'),
('Foto i Kamery'),
('Telefony i Smartfony'),
('Konsole i Gry'),
('AGD Duze'),
('AGD Male');

INSERT INTO PRODUKTY (NAZWA_PRODUKTU,MODEL_PRODUKTU,CENA_PRODUKTU,ILOSC_PRODUKTU,ID_PRODUCENTA,ID_GRUPY_PRODUKTOWEJ) VALUES 
('Telewizor','ASD-6587',2500,300,1,1),
('Telewizor','GFH-8712',1500,150,9,1),
('Telewizor','JUSD-76',1000,100,12,1),
('Telewizor','WE-6543',1700,125,10,1),
('Telewizor','JCX-3890',800,180,5,1),
('Telewizor','UIOP-8',1100,90,6,1),
('Telewizor','REWD-143',900,60,8,1),
('Telewizor','CXZ-7954',1600,140,2,1),
('Telewizor','IOY-91',1350,70,1,1),
('Telewizor','AAC-1322',1600,85,1,1),
('Telewizor','FGD-476764',1270,100,2,1),
('Telewizor','ADSJ-23',900,80,6,1),
('Telewizor','OS-765',760,50,5,1),
('Projektor','L-34',1500,40,1,1),
('Projektor','H-02',1200,45,3,1),
('Projektor','TY-34',1700,60,1,1),
('Projektor','A-8754',1100,35,4,1),
('Projektor','IU-7445',1900,90,1,1),
('Zestaw kina domowego','ER-33334',2899,30,2,1),
('Zestaw kina domowego','UUG-647',2500,50,1,1),
('Zestaw kina domowego','W-98',3500,40,12,1),
('Zestaw kina domowego','OA-8978',2200,35,6,1),
('Zestaw kina domowego','UI-9595',1800,38,2,1),
('Laptop','OJFYUFU',2000,50,16,2),
('Laptop','FTFKG',2500,45,17,2),
('Laptop','DRHDR',3000,55,16,2),
('Laptop','GFGGHGH',2300,30,11,2),
('Laptop','POOPUI',2600,50,1,2),
('Laptop','DYUFGDG',1600,58,8,2),
('Laptop','SDAFES',2450,45,16,2),
('Laptop','POPFJMN',1899,48,1,2),
('Laptop','ZDGHNK',1500,60,2,2),
('Laptop','GYUTFD',3000,54,2,2),
('Monitor','3-DSD',500,30,1,2),
('Monitor','8-JF',650,35,2,2),
('Tablet','JKLJL',1800,200,6,2),
('Tablet','AASSDKL',1900,220,7,2),
('Tablet','869VEVD',1500,150,6,2),
('Tablet','87T8G8',1200,100,15,2),
('Tablet','D7V87D',1450,160,15,2),
('Tablet','56CED6',1299,90,2,2),
('Tablet','456BNGD',900,90,5,2),
('Tablet','79V46WX3',2100,140,1,2),
('Kamera','85456',300,70,12,3),
('Kamera','78563',2500,100,1,3),
('Kamera','39726',1300,65,10,3),
('Kamera','3536367',1400,90,11,3),
('Kamera','6544336',900,49,3,3),
('Kamera','34768768',1800,80,4,3),
('Dron','SYTX',3000,30,1,3),
('Dron','IOJ',3500,50,17,3),
('Aparat cyfrowy','SYTX',3000,60,18,3),
('Aparat cyfrowy','GIDD',2000,45,19,3),
('Aparat cyfrowy','EQQW',1700,90,20,3),
('Aparat cyfrowy','DRT',1900,47,19,3),
('Aparat cyfrowy','YUGYU',2300,70,19,3),
('Aparat cyfrowy','SFD',2550,46,20,3),
('Aparat cyfrowy','OIJO',1900,65,18,3),
('Telefon stacjonarny','34J3J4',500,40,1,4),
('Telefon stacjonarny','7G6F68',900,45,2,4),
('Telefon stacjonarny','5D47',850,49,9,4),
('Smartfon','GVYGD',2300,150,1,4),
('Smartfon','OJJHS',1800,90,7,4),
('Smartfon','JIOJDR',1400,100,11,4),
('Smartfon','5UCR55',1999,89,2,4),
('Smartfon','5C5CC7',900,50,4,4),
('Smartfon','8D48D4',1180,40,10,4),
('Smartfon','TR609',900,70,8,4),
('Smartfon','346C6V',2100,110,1,4),
('Smartfon','34EDRT',1760,85,2,4),
('Smartfon','3232AS3',2400,40,11,4),
('Smartfon','UIUGYF',1400,100,17,4),
('Smartfon','DRTF89',1250,60,15,4),
('Smartfon','RFDTR',1330,54,9,4),
('Smartfon','GYUOLK',1220,120,1,4),
('Smartfon','9UYHED',800,35,6,4),
('Smartwatch','UYGU',1500,30,1,4),
('Smartwatch','WSTUI',1470,45,11,4),
('Konsola','85670',1800,90,2,5),
('Konsola','23452',1770,120,2,5),
('Konsola','9776',2200,130,2,5),
('FIFA 15','HJTUYR',150,180,21,5),
('FIFA 18','TRDRTD',200,300,21,5),
('NHL 17','UIHGGP',130,100,21,5),
('NBA 18','67VT76',190,300,21,5),
('Pralka','785642',2400,60,1,6),
('Pralka','74523',2300,50,23,6),
('Pralka','987754',1800,45,22,6),
('Pralka','24565',1750,90,1,6),
('Suszarka','LHDPDFD',1300,60,24,6),
('Suszarka','POUIYTY',1530,67,24,6),
('Suszarka','QWSQOSO',1900,100,25,6),
('Suszarka','QAZES',1900,62,1,6),
('Lodowka','9876FJ',800,49,25,6),
('Lodowka','ZXRT7G',1300,54,24,6),
('Lodowka','4V6RY',1230,67,1,6),
('Lodowka','23MNE9N3',1600,80,22,6),
('Lodowka','73BEB',1100,90,23,6),
('Zmywarka','3CVBNK',1000,50,23,6),
('Zmywarka','98NDV',1300,53,25,6),
('Zmywarka','CFYHHIO',900,58,22,6),
('Zmywarka','IUYUG',1250,50,23,6),
('Zmywarka','09N0N',1000,40,24,6),
('Odkurzacz','78545',900,90,1,7),
('Odkurzacz','7GF878',1100,100,25,7),
('Odkurzacz','X54Z5',800,120,25,7),
('Odkurzacz','7FXX56SR',1400,87,4,7),
('Odkurzacz','2XZ55',1050,50,4,7),
('Odkurzacz','2WSES',1400,120,1,7),
('Zelazko','SDASD',300,120,1,7),
('Zelazko','4CVB7H',250,70,4,7),
('Zelazko','34SD5F',600,60,4,7),
('Zelazko','37E9WBY',800,40,10,7),
('Zelazko','92WN0S',1000,90,10,7),
('Blender','2WXW54',400,80,1,7),
('Blender','89N9B',450,60,10,7),
('Blender','78G9',200,80,5,7),
('Golarka','78VC689',200,130,9,7),
('Golarka','87TVZW45',230,110,12,7),
('Mikser','90YGFDTY',400,90,1,7),
('Mikser','8TGC',450,95,2,7),
('Mikser','0N9UWB89',350,80,6,7);

INSERT INTO GRUPY_WIEKOWE (NAZWA_GRUPY_WIEKOWEJ) VALUES 
('0-10 lat'),
('11-20 lat'),
('21-30 lat'),
('31-40 lat'),
('41-50 lat'),
('51-60 lat'),
('61-70 lat'),
('71-80 lat'),
('81-90 lat'),
('91-100 lat');
 
INSERT INTO KLIENCI (IMIE_KLIENTA,NAZWISKO_KLIENTA,PLEC_KLIENTA,ROK_URODZENIA,E_MAIL_KLIENTA,TELEFON_KLIENTA,ULICA_KLIENTA,NUMER_DOMU_KLIENTA,NUMER_LOKALU_KLIENTA,KOD_POCZTOWY_KLIENTA,MIASTO_KLIENTA,ID_GRUPY_WIEKOWEJ) VALUES 
('Marian','Baryla','M',1985,'baryla@mail.pl',786245245,'Fiolkowa',23,4,'00-234','Warszawa',4),
('Sebastian','Watroba','M',1970,'watroba@mail.pl',753432251,'Klonowa',21,1,'10-743','Warszawa',5),
('Anna','Palka','K',1973,'palka@mail.pl',897546562,'Koszykowa',345,9,'54-734','Warszawa',5),
('Joanna','Czechowska','K',1979,'czechowska@mail.pl',246547856,'Lubelska',987,234,'87-123','Warszawa',4),
('Pawel','Wierzba','M',1990,'wierzba@mail.pl',972356768,'Mietowa',32,12,'01-345','Warszawa',3),
('Antoni','Ryjak','M',1995,'ryjak@mail.pl',254357686,'Deszczowa',679,78,'23-532','Warszawa',3),
('Marcin','Mucha','M',1998,'mucha@mail.pl',768764552,'Drozda',87,1,'75-768','Warszawa',5),
('Maria','Pigula','K',1968,'pigula@mail.pl',436769879,'Zelazna',2,1,'64-634','Warszawa',5),
('Jozef','Kurowski','M',1950,'kurowski@mail.pl',345646558,'Jelenia',1,1,'87-234','Warszawa',7),
('Irena','Mroz','K',1929,'mroz@mail.pl',764464545,'Ognista',53,87,'23-987','Warszawa',9),
('Agata','Rogowicz','K',2009,'rogowicz@mail.pl',232242433,'Swierkowa',89,123,'00-234','Warszawa',1),
('Roman','Guzowski','M',1926,'guzowski@mail.pl',347677887,'Rolnicza',12,9,'78-183','Warszawa',10),
('Alicja','Wolak','K',1956,'wolak@mail.pl',839274829,'Wodna',1,76,'65-654','Warszawa',7),
('Adam','Chojnowski','M',1961,'chojnowski@mail.pl',818182882,'Kacza',17,178,'32-423','Warszawa',6),
('Jan','Ciechocinski','M',1976,'ciechocinski@mail.pl',283892893,'Zwirkowa',54,9,'87-384','Warszawa',5),
('Krzysztof','Baranowski','M',1979,'baranowski@mail.pl',828201291,'Blotna',12,81,'00-914','Warszawa',4),
('Krystyna','Wiatrowicz','K',1990,'wiatrowicz@mail.pl',781782172,'Strumyczkowa',8,4,'81-893','Warszawa',3),
('Bogdan','Jasinski','M',1963,'jasinski@mail.pl',893891221,'Muzyczna',86,61,'23-975','Warszawa',6),
('Katarzyna','Kurkowska','K',1993,'kurkowska@mail.pl',786136121,'Chabrowa',781,321,'82-343','Warszawa',3),
('Zenon','Solski','M',1947,'solski@mail.pl',768453456,'Runowska',916,3,'52-864','Warszawa',8),
('Barbara','Krakowiak','K',1925,'krakowiak@mail.pl',893762621,'Zlota',372,81,'94-423','Warszawa',9),
('Rafal','Wojcik','M',1965,'wojcik@mail.pl',896256689,'Konwaliowa',64,3,'07-129','Warszawa',6),
('Melania','Szymanska','K',2010,'szymanska@mail.pl',894734561,'Bambusowa',2,5,'92-375','Warszawa',1),
('Michal','Kozlowski','M',1940,'kozlowski@mail.pl',132727323,'Kremowa',27,735,'94-445','Warszawa',8),
('Natalia','Mazur','K',2006,'mazur@mail.pl',563473783,'Orzechowa',83,543,'67-564','Warszawa',2),
('Wiktoria','Krawczyk','K',1949,'krawczyk@mail.pl',768376373,'Zajecza',823,634,'93-293','Warszawa',7),
('Igor',' Nowak','M',1986,'nowak@mail.pl',789481289,'Wspolna',7,1,'75-153','Warszawa',4),('Roman','Jankowski','M',1953,'jankowski@mail.pl',892189122,'Marszalkowska',226,153,'73-876','Warszawa',7),
('Justyna','Pawlak','K',1987,'pawlak@mail.pl',238923893,'Fantazyjna',5,5,'33-542','Warszawa',4),
('Marta','Sikorska','K',2013,'sikorska@mail.pl',278626062,'Radarowa',982,312,'00-234','Warszawa',1),
('Filip','Duda','M',1979,'duda@mail.pl',367687897,'Wilenska',76,123,'00-234','Warszawa',4),
('Jerzy','Wilk','M',1963,'wilk@mail.pl',478866868,'Brzozowa',73,23,'34-643','Warszawa',6),
('Hubert','Urbanski','M',1972,'urbanski@mail.pl',363893789,'Nowoursynowska',73,12,'00-354','Warszawa',5),
('Renata','Makowska','K',1960,'makowska@mail.pl',789768562,'Czekoladowa',8,234,'42-755','Warszawa',6),
('Maciej','Czerwinski','M',2003,'czerwinski@mail.pl',894523893,'Meksykanska',42,2,'87-565','Warszawa',2),
('Anastazja','Kozak','K',1978,'kozak@mail.pl',785443567,'Malinowa',454,231,'38-545','Warszawa',4),
('Kornelia','Zak','K',1994,'zak@mail.pl',897233782,'Koscielna',345,43,'54-255','Warszawa',3),
('Maja','Kot','K',2089,'kot@mail.pl',765676722,'Blokowa',13,1345,'65-132','Warszawa',3),
('Zofia','Krupa','K',1986,'krupa@mail.pl',738612381,'Zabkowska',53,675,'12-876','Warszawa',4),
('Mieczyslaw','Smiech','M',1969,'smiech@mail.pl',891289121,'Gruba',876,123,'54-123','Warszawa',5),
('Aniela','Tomaszewska','K',1997,'tomaszewska@mail.pl',322242342,'Uranowa',234,45,'98-768','Warszawa',3),
('Slawomir','Plot','M',1981,'plot@mail.pl',893389221,'Topolowa',232,126,'66-238','Warszawa',4),
('Marlena','Kruk','K',1944,'kruk@mail.pl',893762762,'Pszenna',213,754,'13-764','Warszawa',8),
('Lukasz','Sowa','M',1977,'sowa@mail.pl',467488675,'Traugutta',212,1,'00-004','Warszawa',5),
('Szymon','Piasecki','M',1993,'piasecki@mail.pl',347689899,'Morska',63,5,'85-145','Warszawa',3),
('Zygmunt','Sosnowski','M',1936,'sosnowski@mail.pl',625276322,'Roskoszna',2,9,'00-234','Warszawa',9),
('Stanislaw','Slomkowski','M',1944,'slomkowski@mail.pl',223563768,'Czysta',861,41,'00-234','Warszawa',8),
('Janina','Sofa','K',1938,'sofa@mail.pl',324527678,'Krzykliwa',476,8,'76-123','Warszawa',8),
('Albert','Wronowicz','M',1966,'wronowicz@mail.pl',382429231,'Lustrzana',712,76,'78-123','Warszawa',6),
('Andrzej','Sobolewski','M',1975,'sobolewski@mail.pl',345456781,'Mleczna',987,1,'00-234','Warszawa',5),
('Ryszard','Pisowski','M',1999,'pisowski@mail.pl',346676878,'Ruska',22,4,'87-876','Warszawa',2); 

 
create or replace function data_faktury_fun(nr numeric(3)) returns date as 

begin 

declare @rok numeric(4), 
@dzien numeric(2), 
@miesiac numeric(2), 
@data1 date

set @rok=0

select rok_urodzenia+round(rand()*17,0)+18 into @rok from klienci where id_klienta=@nr
if (@rok>2017) 
begin 
set @rok=2017
end
set @miesiac=round(rand()*11,0)+1
if (@miesiac=2)
begin 
set @dzien=round(rand()*27,0)+1
end
else
begin 
set @dzien=round(rand()*29,0)+1
end

if (@rok!=0)
begin
set @data1=date(@rok||'-'||@miesiac||'-'||@dzien)
end 
else 
begin
select rok_urodzenia+round(rand()*17,0)+18 into @rok from klienci where id_klienta=@nr
if (@rok>2017) 
begin 
set @rok=2017
end
set @data1=date(@rok||'-'||@miesiac||'-'||@dzien)
end
return @data1

end;



create or replace function id_klienta_fun () 
returns numeric as 

begin

declare @liczba1 numeric(3),
@liczba2 numeric(3)

select min(id_klienta), max(id_klienta) into @liczba1,@liczba2 from klienci
return round(rand()*@liczba2-1,0)+1

end;

create or replace function id_produktu_fun () returns numeric as 

begin

declare @liczba1 numeric(3),
@liczba2 numeric(3)

select min(id_produktu), max(id_produktu) into @liczba1,@liczba2 from produkty
return round(rand()*@liczba2-1,0)+1

end;


create or replace procedure generator (ile_razy numeric default 1,sek numeric default 0) as 

begin

declare @pozycja numeric(2),
@wartosc_f numeric(8,2),
@liczba numeric(2),
@liczba1 numeric(4),
@nr_f numeric(3),
@nr_p numeric(3),
@cena_p numeric(8,2),
@data_f date,
@id_k numeric(3),
@j numeric(4),
@a numeric(4),
@ile_sek numeric,
@char1 char(12)

set @a=1
if sek!='0'
begin
set @ile_sek=round((@sek/@ile_razy),5) --ile opoznie kazdy nawrot petli
end

while @a<=@ile_razy begin --ile transakcji wygenerowac
if sek!='0'
begin
set @char1=convert(char(12),@ile_sek)

waitfor delay '00:00:'+@char1
end
set @liczba1=0
set @liczba=1
set @wartosc_f=0
set @id_k=id_klienta_fun() --losuje id klienta
set @data_f=data_faktury_fun(@id_k) --losuje id faktury

insert into faktury (data_faktury,wartosc_faktury,termin_platnosci,id_klienta) 
values (@data_f,0,@data_f+14,@id_k)

set @pozycja=round(rand()*4,0)+1 --ile produktow kupi klient
set @nr_f=faktury_seq.currval
set @j=1


while @j<=@pozycja begin --tyle razy ile klient kupil produktow

while @liczba1<@liczba begin  --jesli na magazynie jest mniej niz chce klient
set @liczba=round(rand()*4,0)+1  --ile sztuk produktu
set @nr_p=id_produktu_fun()

select ilosc_produktu into @liczba1 from produkty where id_produktu=@nr_p
 
end

select round((cena_produktu*1.1),0) into @cena_p from produkty where id_produktu=@nr_p
--pobieram cene


insert into faktury_pozycje values (@nr_f,@j,@liczba,@cena_p,@nr_p)
update produkty set ilosc_produktu=ilosc_produktu-@liczba where id_produktu=@nr_p


set @wartosc_f=round(@wartosc_f+(@liczba*@cena_p),0)--zliczam wartosc faktury
set @j=@j+1
end

update faktury set wartosc_faktury = @wartosc_f where id_faktury=@nr_f
--wkladam do bazy wartosc faktury

set @a=@a+1
end
end;

create or replace view Zestawienie_sprzedazy as 
select nazwa_producenta "Producent",nazwa_produktu "Produkt", 
model_produktu "Model",p.id_produktu "Id produktu",
sum(liczba) "Suma w danym roku", year(data_faktury) "Rok"
from producenci pp,faktury_pozycje f, faktury ff, produkty p 
where f.id_faktury=ff.id_faktury and f.id_produktu=p.id_produktu and
pp.id_producenta=p.id_producenta group by p.id_produktu,nazwa_produktu,
model_produktu,nazwa_producenta,year(data_faktury) 
order by "Rok" desc,"Suma w danym roku"desc,"Id produktu";

create or replace view Stan_magazynu as 
select nazwa_producenta "Producent",nazwa_produktu "Produkt",id_produktu "Id produktu",  
model_produktu "Model", ilosc_produktu "Ilosc"  
from produkty p, producenci pr where p.id_producenta=pr.id_producenta order by 
id_produktu;

create or replace view Zyski as 
select year(data_faktury) "Rok",month(data_faktury) "Miesiac", 
sum((liczba * cena_zakupu) - (liczba* cena_produktu)) "Zysk" 
from faktury_pozycje f,produkty p,faktury ff where 
f.id_produktu=p.id_produktu and ff.id_faktury=f.id_faktury 
group by year(data_faktury),month(data_faktury) 
order by "Rok" desc,"Miesiac";

create or replace view Zestawienie_sprzedazy_krzyzowo as 
select p.id_produktu,nazwa_producenta,nazwa_produktu,model_produktu, 
sum(case when (year(data_faktury)) between 1918 and 1948 then liczba else 0 end)as "1938-1948",
sum(case when (year(data_faktury)) between 1949 and 1958 then liczba else 0 end)as "1949-1958",
sum(case when (year(data_faktury)) between 1959 and 1968 then liczba else 0 end)as "1959-1968",
sum(case when (year(data_faktury)) between 1969 and 1978 then liczba else 0 end)as "1969-1978",
sum(case when (year(data_faktury)) between 1979 and 1988 then liczba else 0 end)as "1979-1988",
sum(case when (year(data_faktury)) between 1989 and 1998 then liczba else 0 end)as "1989-1998",
sum(case when (year(data_faktury)) between 1999 and 2008 then liczba else 0 end)as "1999-2008",
sum(case when (year(data_faktury)) between 2009 and 2018 then liczba else 0 end)as "2009-2018",
sum(Liczba) as "Suma"
from faktury_pozycje fa, faktury f,produkty p,producenci pp where p.id_producenta=pp.id_producenta and
fa.id_faktury=f.id_faktury and p.id_produktu=fa.id_produktu 
group by p.id_produktu,nazwa_produktu,model_produktu,nazwa_producenta 

union

select null,null,null,'Razem',
sum(case when (year(data_faktury)) between 1918 and 1948 then liczba else 0 end)as "1938-1948",
sum(case when (year(data_faktury)) between 1949 and 1958 then liczba else 0 end)as "1949-1958",
sum(case when (year(data_faktury)) between 1959 and 1968 then liczba else 0 end)as "1959-1968",
sum(case when (year(data_faktury)) between 1969 and 1978 then liczba else 0 end)as "1969-1978",
sum(case when (year(data_faktury)) between 1979 and 1988 then liczba else 0 end)as "1979-1988",
sum(case when (year(data_faktury)) between 1989 and 1998 then liczba else 0 end)as "1989-1998",
sum(case when (year(data_faktury)) between 1999 and 2008 then liczba else 0 end)as "1999-2008",
sum(case when (year(data_faktury)) between 2009 and 2018 then liczba else 0 end)as "2009-2018",
sum(Liczba) as "Suma" from faktury_pozycje fa, faktury f,produkty p where fa.id_faktury=f.id_faktury and p.id_produktu=fa.id_produktu 
group by null,'Razem' order by id_produktu;
