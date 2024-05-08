--get the median tie score from match table
--the median is the value in the middle of a sorted set of values (for odd counts of values)
--if there are an even number of total values, the median is the average/mean of the two middle values
select avg(home_team_goal) as median_tie_score from (
	select home_team_goal from (
		select home_team_goal from (
			--6596 rows 
			select id, home_team_goal, away_team_goal from match
			where home_team_goal = away_team_goal
		)x 
		order by home_team_goal
		--limit full count / 2 (halfway point) + 1
		limit 6596/2 + 1
	)y
	order by home_team_goal desc 
	limit 2 --so we are getting on either side of the middle
)z;

--TOP alternative for SQLite:
SELECT [field names] FROM [table name] ORDER BY [field name] DESC LIMIT [number of records];

--using CLI to get column names
PRAGMA table_info [table name]
