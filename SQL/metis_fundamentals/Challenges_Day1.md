# Challenge 1: Creating and Populating Tables

### Platform and Data
Please complete this and all module challenges using [DB Browser for SQLite](http://sqlitebrowser.org). While you will likely use a different platform at work, DB Browser was chosen because it's open-source and cross-platform. The SQL language and functionality is identical for most applications.

> Note: buttons and code are formatted as `plain text` throughout the course.

Download the [European Soccer SQLite database](https://www.kaggle.com/hugomathien/soccer/downloads/soccer.zip) and use `open database` to load the sqlite3 file. This contains soccer/football match info from 2008-2016 for a number of European leagues. The SQL principles we'll use on this practice set have numerous business applications.

Dataset contains:

- 25k+ matches
- 10k+ players
- 11 European countries
- Seasons 2008 to 2016
- Players and Teams' attributes (sourced from EA Sports)
- FIFA video game series, including weekly updates
- Team line-up with squad formation (X, Y coordinates)
- Betting odds from up to 10 providers
- Detailed match events (goal types, possession, corner, cross, fouls, cards etc...) for 10k+ matches 

## Challenges
Note: you can right click on tables to browse and edit them. Feel free to use this GUI functionality as a spot check on your SQL code.

1. Create `Country2` table which duplicates the already-existing `Country` table structure. Note that you must use the `Execute SQL` tab at top left.

1. Populate the first row/record in `Country2` to match `Country` using `INSERT INTO`.

1. Run the SQL command again. Does it fail, and what error do you get?

1. Insert the second country (England) without specifying its `id`.

1. What `id` is auto-generated? Can you change it to match the original table?

1. Populate the rest of `Country2` to match `Country` using `INSERT INTO`.

1. Drop the `Country` table.

1. Rename `Country2` to `Country`.

1. Add the BOOLEAN column `big_five`.

1. Uh-oh! We made a bunch of NULLs and it will take more work to set everything than to default to FALSE and update the five correct entries to TRUE. Please drop the column (this may fail with SQLite but we'll talk about why).

1. Recreate `big_five` with FALSE default.

1. Tag the [correct countries](https://fivethirtyeight.com/features/whos-likely-to-win-the-five-big-european-soccer-leagues/) with a TRUE.


## Resources
- [Distinctive Features Of SQLite](https://www.sqlite.org/different.html)
- [W3 Create Table](https://www.w3schools.com/Sql/sql_create_table.asp)
- [W3 Alter Table](https://www.w3schools.com/sql/sql_alter.asp)
- [SQLite Tutorial](http://www.sqlitetutorial.net)
