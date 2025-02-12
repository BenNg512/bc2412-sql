create database bootcamp_exercise4;
use bootcamp_exercise4;

create table players(
	player_id int not null unique,
	group_id int not null
);

create table matches(
	match_id integer not null unique,
    first_player integer not null,
    second_player integer not null,
    first_score integer not null,
    second_score integer not null
);

insert into players (player_id, group_id)
values (20, 2), (30, 1), (40, 3), (45, 1), (50, 2), (65, 1)



