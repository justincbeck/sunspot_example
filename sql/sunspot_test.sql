drop database sunspot_test;

create database sunspot_test;

use sunspot_test;

create table parents (
	id int(11) not null auto_increment,
	name VARCHAR(50),
	PRIMARY KEY (id)
);

create table children (
	id INT(11) not null auto_increment,
	name VARCHAR(50),
	-- parent_id INT(11) not null,
	PRIMARY KEY (id)
	-- INDEX par_ind (parent_id),
	-- FOREIGN KEY (parent_id) REFERENCES parents(id)
);
