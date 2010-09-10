drop database sunspot_example;

create database sunspot_example;

use sunspot_example;

create table parents (
	id int(11) not null auto_increment,
	name VARCHAR(50),
	PRIMARY KEY (id)
);

create table children (
	id INT(11) not null auto_increment,
	name VARCHAR(50), 
	PRIMARY KEY (id)
);

create table parent_child (
	parent_id INT(11) not null,
	child_id INT(11) not null
);
