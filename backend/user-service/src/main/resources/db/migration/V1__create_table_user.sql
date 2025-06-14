CREATE TABLE `users` (
	id varchar(100) NOT NULL,
	user_name varchar(100) NULL,
	password varchar(300) NULL,
	roles varchar(200) NULL,
	first_name varchar(100) NULL,
	last_name varchar(100) NULL,
	create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	create_by varchar(100) DEFAULT 'SYSTEM' NOT NULL,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	update_by varchar(100) DEFAULT 'SYSTEM' NOT NULL,
	CONSTRAINT BOOK_PK PRIMARY KEY (id)
);