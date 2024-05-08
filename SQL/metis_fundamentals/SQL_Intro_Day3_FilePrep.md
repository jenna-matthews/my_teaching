## Prep Data


This challenge focuses on using the three concepts learned today to analyze tennis data from [here](https://archive.ics.uci.edu/ml/datasets/Tennis+Major+Tournament+Match+Statistics). 
Click `Data Folder` and download the zip file, then load into DB Browser. 
Also note the attribute description on the site; this will help interpret the data!

1. Our CSV files have missing entries and entries that are the string `NA`. We'll use the command line program `sed` to fix that:

```bash
#cd to directory 

sed -i.bak s/NA//g AusOpen-women-2013.csv
```

*Windows Command - see [here](https://blogs.msdn.microsoft.com/zainnab/2007/07/08/grep-and-sed-with-powershell/) *
```bash
#cd to directory 
cat AusOpen-women-2013.csv | % { $_ -replace "NA","" }
```

Repeat this **for each** CSV file in the data set! This looks for "NA" values and replaces with nothing so SQL can render to NULL.

Next, create a new database called `tennis` with `New Database` button at top. Save it to your SQL folder.

DB Browser has a "black box" import function which works the same but doesn't allow basic SQL commands. Go to `File>Import>Table from CSV file` and be sure to select "first row as header" option. Do this for all tables.

>If US Open or Wimbledon Ladies throws an error, change ST2.1 to ST1.2 (raw data typo).

---
Now, some platforms allow data load from a CSV file into a table like this:

```sql
COPY 
      aus_ladies_2013
FROM 
      '/home/tennis/AusOpen-women-2013.csv'
DELIMITER 
      ','
CSV HEADER;
```
If you want to use another platform for this exercise, use this code first to design your table:

```sql
CREATE TABLE  aus_ladies_2013 (
      player1 VARCHAR(255),
      player2 VARCHAR(255),
      round INT,
      result INT,
      fnl1 DOUBLE PRECISION,
      fnl2 DOUBLE PRECISION,
      fsp_1 DOUBLE PRECISION,
      fsw_1 DOUBLE PRECISION,
      ssp_1 DOUBLE PRECISION,
      ssw_1 DOUBLE PRECISION,
      ace_1 INT,
      dbf_1 INT,
      wnr_1 INT,
      ufe_1 INT,
      bpc_1 INT,
      bpw_1 INT,
      npa_1 INT,
      npw_1 INT,
      tpw_1 INT,
      st1_1 INT,
      st2_1 INT,
      st3_1 INT,
      st4_1 INT,
      st5_1 INT,
      fsp_2 DOUBLE PRECISION,
      fsw_2 DOUBLE PRECISION,
      ssp_2 DOUBLE PRECISION,
      ssw_2 DOUBLE PRECISION,
      ace_2 INT,
      dbf_2 INT,
      wnr_2 INT,
      ufe_2 INT,
      bpc_2 INT,
      bpw_2 INT,
      npa_2 INT,
      npw_2 INT,
      tpw_2 INT,
      st1_2 INT,
      st2_2 INT,
      st3_2 INT,
      st4_2 INT,
      st5_2 INT);
```
>We have to specify the schema of our table, with detail about [data types](http://www.postgresql.org/docs/9.3/static/datatype.html).

*Hint:* Some platforms allow you to make a new table with the same schema as an existing table. For example:

```sql
CREATE TABLE 
      aus_men_2013 
(LIKE 
      aus_ladies_2013);
```
