/*DROP TABLE faktura CASCADE CONSTRAINTS;

DROP TABLE faktura_pozycje CASCADE CONSTRAINTS;

DROP TABLE grupy_produktowe CASCADE CONSTRAINTS;

DROP TABLE grupy_wiekowe CASCADE CONSTRAINTS;

DROP TABLE klienci CASCADE CONSTRAINTS;

DROP TABLE producent CASCADE CONSTRAINTS;

DROP TABLE produkty CASCADE CONSTRAINTS;

DROP TABLE wojewodztwa CASCADE CONSTRAINTS;*/

CREATE TABLE faktura (
    id_faktury         NUMBER(2) NOT NULL,
    data_faktury       DATE NOT NULL,
    wartosc_faktury    NUMBER(6,2) NOT NULL,
    termin_platnosci   DATE NOT NULL,
    id_klienta         NUMBER(3) NOT NULL
);

ALTER TABLE faktura ADD CONSTRAINT faktura_pk PRIMARY KEY ( id_faktury );

CREATE TABLE faktura_pozycje (
    id_faktury    NUMBER(2) NOT NULL,
    pozycja       NUMBER(2) NOT NULL,
    liczba        NUMBER(2) NOT NULL,
    cena_zakupu   NUMBER(6,2) NOT NULL,
    id_produktu   NUMBER(3) NOT NULL
);

ALTER TABLE faktura_pozycje ADD CONSTRAINT faktura_pozycje_pk PRIMARY KEY ( pozycja,
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
    "E-mail_Klienta"       VARCHAR2(30),
    telefon_klienta        NUMBER(9) NOT NULL,
    ulica_klienta          VARCHAR2(20) NOT NULL,
    numer_domu_klienta     NUMBER(4) NOT NULL,
    numer_lokalu_klienta   NUMBER(4),
    kod_pocztowy_klienta   VARCHAR2(20) NOT NULL,
    miasto_klienta         VARCHAR2(30) NOT NULL,
    id_grupy_wiekowej      NUMBER(2) NOT NULL,
    id_wojewodztwa         NUMBER(2) NOT NULL
);

ALTER TABLE klienci ADD CONSTRAINT klienci_pk PRIMARY KEY ( id_klienta );

CREATE TABLE producent (
    id_producenta             NUMBER(2) NOT NULL,
    nazwa_producenta          VARCHAR2(20) NOT NULL,
    "E-mail_Producenta"       VARCHAR2(30),
    telefon_producenta        NUMBER(9) NOT NULL,
    ulica_producenta          VARCHAR2(20) NOT NULL,
    numer_domu_producenta     NUMBER(4) NOT NULL,
    numer_lokalu_producenta   NUMBER(4),
    kod_pocztowy_producenta   VARCHAR2(20) NOT NULL,
    miasto_producenta         VARCHAR2(30) NOT NULL,
    id_wojewodztwa            NUMBER(2) NOT NULL
);

ALTER TABLE producent ADD CONSTRAINT producent_pk PRIMARY KEY ( id_producenta );

CREATE TABLE produkty (
    id_produktu            NUMBER(3) NOT NULL,
    nazwa_produktu         VARCHAR2(20) NOT NULL,
    cena_produktu          NUMBER(6,2) NOT NULL,
    ilosc_produktu         NUMBER(4) NOT NULL,
    id_producenta          NUMBER(2) NOT NULL,
    id_grupy_produktowej   NUMBER(2) NOT NULL
);

ALTER TABLE produkty ADD CONSTRAINT produkty_pk PRIMARY KEY ( id_produktu );

CREATE TABLE wojewodztwa (
    id_wojewodztwa      NUMBER(2) NOT NULL,
    nazwa_wojewodztwa   VARCHAR2(30) NOT NULL
);

ALTER TABLE wojewodztwa ADD CONSTRAINT wojewodztwa_pk PRIMARY KEY ( id_wojewodztwa );

ALTER TABLE faktura_pozycje
    ADD CONSTRAINT faktura_faktura_pozycje_fk FOREIGN KEY ( id_faktury )
        REFERENCES faktura ( id_faktury );

ALTER TABLE produkty
    ADD CONSTRAINT grupy_produktowe_produkty_fk FOREIGN KEY ( id_grupy_produktowej )
        REFERENCES grupy_produktowe ( id_grupy_produktowej );

ALTER TABLE klienci
    ADD CONSTRAINT grupy_wiekowe_klienci_fk FOREIGN KEY ( id_grupy_wiekowej )
        REFERENCES grupy_wiekowe ( id_grupy_wiekowej );

ALTER TABLE faktura
    ADD CONSTRAINT klienci_faktura_fk FOREIGN KEY ( id_klienta )
        REFERENCES klienci ( id_klienta );

ALTER TABLE produkty
    ADD CONSTRAINT producent_produkty_fk FOREIGN KEY ( id_producenta )
        REFERENCES producent ( id_producenta );

ALTER TABLE faktura_pozycje
    ADD CONSTRAINT produkty_faktura_pozycje_fk FOREIGN KEY ( id_produktu )
        REFERENCES produkty ( id_produktu );

ALTER TABLE klienci
    ADD CONSTRAINT wojewodztwa_klienci_fk FOREIGN KEY ( id_wojewodztwa )
        REFERENCES wojewodztwa ( id_wojewodztwa );

ALTER TABLE producent
    ADD CONSTRAINT wojewodztwa_producent_fk FOREIGN KEY ( id_wojewodztwa )
        REFERENCES wojewodztwa ( id_wojewodztwa );
