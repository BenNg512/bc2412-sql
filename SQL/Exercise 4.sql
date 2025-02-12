create database bootcamp_exercise4;
use bootcamp_exercise4;

create table players(
	player_id int not null unique,
	group_id int not null
);

insert into players (player_id, group_id)
values (20, 2), (30, 1), (40, 3), (45, 1), (50, 2), (65, 1)
;

create table matches(
	match_id integer not null unique,
    first_player integer not null,
    second_player integer not null,
    first_score integer not null,
    second_score integer not null
);

insert into matches (match_id, first_player, second_player, first_score, second_score)
values
(1, 30, 45, 10, 12),
(2, 20, 50, 5, 5),
(13, 65, 45, 10, 10),
(5, 30, 65, 3, 15),
(42, 45, 65, 8, 4)
;

with scores_list as(
    SELECT first_player AS player_id, first_score AS score
    FROM matches
    UNION ALL
    SELECT second_player AS player_id, second_score AS score
    FROM matches
	), 
    
	group_scores as(
	SELECT p.group_id, p.player_id, coalesce(sl.score, 0) as score
	from players p
	left join scores_list sl
	on sl.player_id = p.player_id
	), 
    
	players_scores as(
	select group_id, player_id, SUM(score) as total_scores
	from group_scores
	group by player_id
	order by group_id
	)
    
SELECT group_id, player_id
FROM (
    SELECT group_id, player_id, total_scores,
           ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY total_scores DESC, player_id ASC) AS rn
    FROM players_scores
) subquery
WHERE rn = 1
ORDER BY group_id;







