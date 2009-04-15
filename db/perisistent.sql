drop table if exists persistent_logins;
create table persistent_logins (
id	    int		not null auto_increment,
uid	    varchar(100) not null,
user_id	    int,
created_on  datetime,
primary key (id)
)
