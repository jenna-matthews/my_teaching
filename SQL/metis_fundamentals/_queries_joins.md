# Challenge 2: Queries and Joins

This challenge focuses on combining and viewing our soccer data in interesting ways. Take a look through the GUI interface to get a feel for what data resides in each table and how you might approach different tasks we covered in the slide deck. Also, feel free to go above and beyond the list below!

## Challenges

Let's focus on the `Player` table: 

1. Select all players who weigh over 200 lbs.
`SELECT * FROM Player WHERE weight > 200;`

1. Sort the above query with the heaviest players first.
`SELECT * FROM Player WHERE weight > 200 ORDER BY weight DESC;`

1. Who are the three heaviest players?
> Note that TOP doesn't work for SQLite
`SELECT * FROM Player WHERE weight > 200 ORDER BY weight DESC LIMIT 3;`
>"Kristof van Hout", "Tim Wiese", "Jeroen Verhoeven"

1. Select all players who weigh less than or equal to 140 lbs and are taller than 185cm.
`SELECT * FROM Player WHERE weight <= 140 AND height > 185 ORDER BY weight DESC;`

1. How many results did you get?
> One, John Stewart

1. Select all players who weigh less than 125 lbs OR are shorter than 140cm.
`SELECT * FROM Player WHERE weight < 125 OR height < 140 ORDER BY weight DESC;`

1. How many results did you get?
> Five

1. Count the number of players between 170cm and 190cm, inclusive.
`SELECT COUNT(*) FROM Player WHERE height BETWEEN 170 and 190;`

1. Unfortunately, SQLite doesn't have good support for CASE. Theoretically, how would you create a `category` column and label players over 190cm as tall, those under 170cm as short, and the rest as average?
```
SELECT player_name, height,
	CASE 
		WHEN height > 190 THEN “tall”
		WHEN height < 170 THEN “short”
		ELSE “average” END AS category
FROM Player;
```

1. Find players with birthdays on February 29 (leap day).
`SELECT * FROM Player WHERE birthday LIKE '%02-29%';`

1. Create a `weight_kg` column using the [conversion formula](https://www.unitconverters.net/weight-and-mass/lbs-to-kg.htm).
`SELECT *, weight*0.45359237 AS weight_kg FROM Player;`

1. Calculate [player BMIs using the metric formulation](https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_1.html) into the `BMI` column.
>Note: we're not saving `weight_kg` so it needs to be computed in the overall formula.
`SELECT *, weight*0.45359237/height/height*10000 AS BMI FROM Player;`

1. Calculate the average BMI of all players.
`SELECT avg(weight*0.45359237/height/height*10000) FROM Player;`

1. Calculate the average BMI of players born on February 29.
`SELECT avg(weight*0.45359237/height/height*10000) FROM Player WHERE birthday LIKE '%02-29%';`

1. Which group has lower BMI?
> Feb 29 group, slightly.

***
Let's introduce joins as we seek to find answers to higher-level questions:

- Which team scored the most points when playing at home?

```
SELECT team_long_name, home_team_api_id, SUM(home_team_goal) AS home_goals 
                      FROM Match 
                      JOIN Team
                      ON Team.team_api_id = Match.home_team_api_id
                      GROUP BY home_team_api_id 
                      ORDER BY home_goals DESC
                      LIMIT 1;
```
- Did this team also score the most points when playing away?

```
SELECT team_long_name, away_team_api_id, SUM(away_team_goal) AS away_goals 
                      FROM Match 
                      JOIN Team 
                      ON Team.team_api_id = Match.away_team_api_id
                      GROUP BY away_team_api_id 
                      ORDER BY away_goals DESC 
                      LIMIT 1;
```
- How many matches resulted in a tie?

```
SELECT COUNT(*) as num_ties
                      FROM Match
                      WHERE away_team_goal = home_team_goal;
```

- What was the median tie score? Use the value determined in the previous question for the number of tie games.

```
WITH _table2 AS (
                           WITH _table1 AS (
                                SELECT home_team_goal
                                FROM Match
                                WHERE away_team_goal = home_team_goal
                                ORDER BY home_team_goal
                                LIMIT 6596/2 + 1
                           )
                           SELECT home_team_goal
                           FROM _table1
                           ORDER BY home_team_goal DESC
                           LIMIT 2
                      )
                      SELECT AVG(home_team_goal) AS median_tie_score
                      FROM _table2;
```

- How many players have Smith for their last name?

`SELECT COUNT(player_name) AS num_names
                      FROM Player
                      WHERE player_name LIKE '% Smith';`

- How many have 'smith' anywhere in their name?

`SELECT COUNT(player_name) AS num_names
                      FROM Player
                      WHERE player_name LIKE '%smith%';`
                      
- What percentage of players prefer their left or right foot?

```
WITH _table1 AS ( SELECT preferred_foot, COUNT(preferred_foot) as num
                           FROM Player_Attributes
                           GROUP BY preferred_foot
                      )
                      SELECT preferred_foot, 100.0 * num / SUM(num) as percentage
FROM _table1

--can also be done like this:
select preferred_foot, total_players, count(*) as players
	,100.0*count(*)/total_players as pct_players_preferred
from Player_Attributes x
	join ( --use this to get the total count of players 
		select 1, count(*) as total_players from Player_Attributes
		) y on 1=1
group by preferred_foot, total_players;
```            


## Resources
- [Intro to Queries](https://www.khanacademy.org/computing/computer-programming/sql)
- [Common SQL Commands](https://www.codecademy.com/articles/sql-commands)
- [Interactive Joins](https://www.w3schools.com/sql/sql_join.asp)
- [Wiki on Joins](https://en.wikipedia.org/wiki/Join_(SQL))
