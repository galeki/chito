drop table if exists groups;
create table groups (
id		int		not null auto_increment,
name		varchar(30)	not null,
space		int		default 0,
file_size_limit	int		default 0,
package_data	text,
bit_opt		int		default 0,
primary key (id)
);
