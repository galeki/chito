drop table if exists users;
create table users (
id		int		not null auto_increment,
name		varchar(30)	not null,
nick		varchar(30),
email		varchar(50),
title		varchar(100),
hashed_password	char(40)	not null,
created_at	datetime	not null,
info		text,
package_data	text,
bit_opt		int		default 0,
cache_space	int,		default -1,
theme		varchar(30),
blog_read	int		default 0,
group_id	int		default 1,
constraint fk_users_group	foreign key (group_id) references groups(id),
primary key (id)
);
drop table if exists categories;
create table categories (
id		int		not null auto_increment,
name		varchar(100)	not null,
user_id		int,
info		text,
created_at	datetime	not null,
position	int		default 0,
constraint fk_categories_user	foreign key (user_id) references users(id),
primary key (id)
);
drop table if exists articles;
create table articles (
id		int		not null auto_increment,
title		varchar(100),
brief		text		null,
content		text,
raw_content	text,
cached_tag_list text		null,
writer		varchar(30)	null,
created_at	datetime	not null,
updated_at	datetime,
read_count	int		default 0,
/*comments_count	int		default 0,*/
package_data	text,
bit_opt		int		default 0,
user_id		int		not null,
category_id	int,
constraint fk_articles_user	foreign key (user_id) references users(id),
constraint fk_articles_categories	foreign key (category_id) references categories(id),
primary key (id)
);
/*drop table if exists articles_categories;
create table articles_categories (
article_id	int		not null,
category_id	int		not null,
constraint fk_ac_article	foreign key (article_id) references articles(id),
constraint fk_ac_category	foreign key (category_id) references categories(id),
primary key (article_id, category_id)
);*/
drop table if exists comments;
create table comments (
id		int		not null auto_increment,
writer		varchar(20)	not null,
content		text		not null,
created_at	datetime	not null,
article_id	int,
user_id		int		not null,
homepage	varchar(200)	null,
email		varchar(50),
bit_opt		int		default 0,
constraint fk_comments_user	foreign key (user_id) references users(id),
constraint fk_comments_article	foreign key (article_id) references articles(id),
primary key (id)
);

drop table if exists taggings;
create table taggings (
id		int		not null auto_increment,
taggable_id	int,
tag_id		int,
taggable_type	varchar(30),
primary key (id)
);

drop table if exists tags;
create table tags (
id		int		not null auto_increment,
name		varchar(30)	not null,
primary key (id)
);
/*
drop table if exists user_files;
create table user_files (
id		int		not null auto_increment,
name		varchar(100),
file_type	varchar(10),
hash		char(40),
description	varchar(200),
created_at	datetime	not null,
user_id		int,
constraint fk_files_user	foreign key (user_id) references users(id),
primary key (id)
);
*/
drop table if exists links;
create table links (
id		int		not null auto_increment,
title		varchar(100)	not null,
url		varchar(200)	not null,
info		text,
created_at	datetime,
user_id		int,
position	int		default 0,
bit_opt		int		default 0,
constraint fk_links_user	foreign key (user_id) references users(id),
primary key (id)
);
