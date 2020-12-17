drop table account cascade;
drop table solution cascade;

create table account (
        id serial primary key,
        username varchar(50) UNIQUE,
        passwd varchar(50) NOT NULL,
        firstName varchar(50),
        lastName varchar(50)
);

create table solution (
        id serial primary key,
        value integer not null,
	expression varchar(200) not null unique,
        accountId integer references account(id)
);

INSERT INTO account(firstName, lastName, username, passwd) values('Alex','Large','bigBoy','sdfdsfd');
INSERT INTO account(firstName, lastName, username, passwd) values('Anne','Lion','anne','lion');
INSERT INTO account(firstName, lastName, username, passwd) values('Linda','Swim','lindah20','fourfivesix');
INSERT INTO account(firstName, lastName, username, passwd) values('Abagail','Silver','coins','silverisbetter');
INSERT INTO account(firstName, lastName, username, passwd) values('Jessie','Burn','matchstick','password1');
INSERT INTO account(firstName, lastName, username, passwd) values('Annie','Cup','coffee','password');
INSERT INTO account(firstName, lastName, username, passwd) values('Diane','Bassell','ssll','passw0rd');
INSERT INTO account(firstName, lastName, username, passwd) values('Steve','Mountain','cliff','cliff');
INSERT INTO account (username, passwd, firstName, lastName) values ('arnold@cs.toronto.edu', 'sdxfdsgger', 'Arnold', 'Rosenbloom');
INSERT INTO account(firstName, lastName, username, passwd) values('Jay','Perlmuter','perl','perl');
INSERT INTO account(firstName, lastName, username, passwd) values('Peter','Piper','pickApeck','Peter');
INSERT INTO account(firstName, lastName, username, passwd) values('Jen','Binghampton','hotel','jbh');
INSERT INTO account(firstName, lastName, username, passwd) values('David','Kleinman','dk@gmail.com','esrever');
INSERT INTO account(firstName, lastName, username, passwd) values('Jesse','Kowalski','eightball@gmail.com','badPassword');
INSERT INTO account(firstName, lastName, username, passwd) values('Ivanna','Grant','ivanna','grant');

