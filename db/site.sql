drop table if exists sites;
create table sites (
id		int		not null auto_increment,
title		varchar(100)	null,
url		varchar(300)	null,
domain		varchar(300)	null,
default_group	int,
default_user	varchar(30)	null,
created_at	datetime	not null,
default_theme	varchar(30)	null,
user_mode	varchar(20)	null,
bit_opt		int		default 0,
primary key (id)
);
