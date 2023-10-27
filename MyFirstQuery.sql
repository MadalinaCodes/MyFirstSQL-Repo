show databases;

select * from information_schema.tables;

select * from information_schema.views;

/* SQL este un limbaj de programare, pot sa lucrez cu el prin executarea unor comenzi de la tastatura, sistemul le preia ca o carte de telefon, in baza de date pot sa stochez diverse informatii*/

show databases;

select * from information_schema.tables;

create database cinema;
create database petclinic;
create database humanresources;
/* Optiuni pentru specificarea bazei de date pe care sa o folosim

1. Dublu click pe numele bazei de date
2. Dam click dreapta pe numele bazei de date si apasam optiunea "Set as default schema"
3. Executam instructiunea use. Ex: use cinema;  use petclinic; use humanresources;
4. Orice instructiune trebuie sa fie terminata cu semnul ";"

*/

/* 

O tabela este formata din urmatoarele elemente:

- numele tabelei
- cel putin o coloana (obligatoriu)
- tip de data pentru fiecare coloana definita (obligatoriu)
- proprietati ale coloanelor (optional)

Tip de date = o proprietate a unei coloane care ii specifica sistemului ce fel de informatii pot fi adaugate pe coloana respectiva
*/

/* Scurtaturi MySQL

CTRL + B -> Formateaza codul 

/* Crearea unei tabele */

CREATE TABLE owners (
    firstName VARCHAR(25) NOT NULL,
    lastName VARCHAR(25) NOT NULL
);

/* adaugarea unei coloane intr-o tabela */
alter table owners
add column age int;

/* stergerea unei coloane dintr-o tabela - doua instructiuni echivalente */
-- alter table owners drop column age;
-- alter table owners drop age;

/* Modify - poate sa modifice proprietatile unei coloane
Atentie!!!
Daca, in momentul in care executam instructiunea, nu specificam toate proprietatile pe care le-am specificat la creare, ele vor fi sterse.
*/

desc owners; -- arata structura tabelei

alter table owners modify firstName char(25) not null;
alter table owners modify lastName char(25) not null;


/* Instructiunea de change ne ajuta sa schimbam numele unei coloane */
alter table owners change lastName ownerLastName char(25) not null;

/* Instructiunea de RENAME ne ajuta sa schimbam numele teabelei */

-- alter table owners rename to petOwner;

/* Instructiunea de DROP TABLE sterge tabela impreuna cu toate informatiile */
-- drop table petOwner; -- Atentie!!! se va sterge tabela cu toate informatiile din ea si nu se mai poate recupera

-- rename table petowner to owners;  
alter table owners change ownerLastName lastName varchar(25);
alter table owners add column dateOfBirth date;

-- Instructiune de insert
insert into owners (firstName, lastName, dateOfBirth, age)
values ('Jim', 'Jameson', '1980-01-31', 43);


-- Instructiune de insert cu mai multe randuri inserate concomitent
insert into owners (firstName, lastName, dateOfBirth, age)
values ('Andrew', 'Smith', '1957-05-20', 66), ('Tom', 'Tompson', '1954-07-28', 69);

-- Instructiune de insert fara specificarea coloanelor, ATENTIE!!! Trebuie in cazul asta sa specificam obligatoriu numarul exact de valori, corespunzator numarului de coloane.
insert into owners values ('Tom', 'Anderson', '1980-01-30', 43);
/* insert into owners values ('Tom', 'Anderson');*/-- Va returna eroare: Error Code: 1136. Column count doesn't match value count at row 1

-- Verificam rezultatele instructiunii insert
select * from owners;

desc owners; -- arata structura tabelei

-- ---------------------------

-- update owners set firstName = 'James';

-- Verificam rezultatele instructiunii de update
select * from owners;

-- -----------------------------
-- Stergerea tuturor inregistrarilor din tabela cu delete
-- delete from owners;

-- Verificam rezultatele instructiunii de delete
select * from owners;

-- -----------------------------
-- Stergerea tuturor inregistrarilor din tabela cu truncate
-- truncate table owners;

-- Verificam rezultatele instructiunii de delete
select * from owners;

-- Diferenta intre DELETE si TRUNCATE:
/* 
- DELETE are capacitatea de a numara inregistrarile pe care le sterge, iar TRUNCATE sterge fara a numara 
- cu DELETE putem sa filtram is sa stergem doar anumite inregistrari, in schimb la TRUNCATE nu putem face filtrare
*/

select * from owners; -- aici selectez toate coloanele din owners

-- select firstName, lastName from owners; -- aici doar doua coloane

insert into owners (firstName, lastName, dateOfBirth, age)
values ('Anton', 'Popescu', '1973-06-25', 50), ('Marin', 'Antonescu', '1967-01-21', 56);

insert into owners (firstName, lastName, dateOfBirth, age)
values ('Winston', 'Churchill', '1874-11-03', 91);

alter table owners add column city varchar(50);

update owners set city = 'Cluj' where firstName = 'Ion';
update owners set dateOfBirth = '1874-11-30' where firstName = 'Winston';

insert into owners (firstName, lastName, dateOfBirth, age)
values ('Ion', 'Ionescu', '1998-01-05', 25);

-- delete from owners where firstName = 'Winston'; -- asa sterg un rand

select * from owners where dateOfBirth > '1970-12-31';
select * from owners where age >= 25;

select * from owners where firstname in ('Ion', 'Marin');
select * from owners where firstname not in ('Ion', 'Marin');

select * from owners where city is null;
select * from owners where city is not null;

select * from owners where age != 25;
select * from owners where firstName != 'Ion';
select * from owners where firstName != 'Jim';
select * from owners where firstName <> 'Jim'; -- <> la fel ca !=

select * from owners where age between 45 and 54;

select * from owners where firstName like 'i%'; -- afiseaza nume care incep cu i
select * from owners where firstName like 'i'; -- fara % afiseaza doar un proprietar care se numeste i
select * from owners where firstName like '%on'; -- afiseaza nume care se termina cu on
select * from owners where firstName like '%n%'; -- afiseaza nume care contin litera n oriunde in nume

select * from owners where dateOfBirth like '1975%'; -- arata cine e nascut in 1975
select * from owners where dateOfBirth like '197%'; -- arata cine e nascut dupa 1970
select * from owners where dateOfBirth like '19%'; -- arata cine e nascut dupa 1900
select * from owners where dateOfBirth like '%02'; -- arata cine e nascut in ziua de 02 
select * from owners where dateOfBirth like '%06%'; -- 06 poate fi oriunde in an/luna/zi
select * from owners where dateOfBirth like '%-06-%'; -- arata cine e nascut in luna 06

select * from owners 
where firstName like '%on'
and dateOfBirth like '197';

select * from owners 
where firstName like '%on'
OR dateOfBirth like '197%'
and city = 'Cluj'; -- and are prioritate daca nu se folosesc paranteze pentru a prioritiza pe OR


select * from owners 
where (firstName like '%on'
OR dateOfBirth like '197%')
and city = 'Cluj'; -- este ca la matematica, and este echivalentul inmultirii sau impartirii si OR ese echivalentul adunarii si scaderii

select sum(age) from owners;
select avg(age) from owners;
select min(age) from owners;
select max(age) from owners;
select count(*) from owners;
select count(city) from owners;

alter table owners add column ownerid int primary key auto_increment;
alter table owners modify column ownerid int auto_increment first;
desc owners; -- describe

select * from owners;
insert into owners (firstName, lastName, dateOfBirth, age) 
values ('Anton',  'Pann', '1796-11-02', 58);

insert into owners (firstName, lastName, dateOfBirth, age) 
values ('Anton',  'Pann', '1796-11-02', 58);


create table pets ( 
petid int not null auto_increment,
race varchar(45) not null,
dateOfBirth date not null,
ownerid int not null,
primary key (petid),
constraint fk_pet_owners foreign key (ownerid) references owners(ownerid) -- fk e foreign key adica cheie secundara
);





