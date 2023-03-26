create database fifa19;



select * from tbl_players;


----***Data Analysis on  FIFA data***----

--Q1 How many players are there in the datasets?

select count(*) as Total_Players from tbl_players;
--since there are no duplicates count will show total distinct players


--Q2 How many nationalities do these players belong to?

select count("Nationality") as number_of_nationalities from tbl_players;
--will show duplicates nationalities as well

select count(distinct "Nationality") as number_of_nationalities from tbl_players;
--will show unique count of nationalities


--Q3 Which nationality has the highest number of players, what are the top 3 nationalities by # of players?

select count(*) as frequency, "Nationality" from tbl_players group by "Nationality";
--will show natinality frequency

select count(*) as frequency,  "Nationality" from tbl_players group by  "Nationality" order by frequency desc;
--will show nationality frequency in decreasing order

select count(*) as frequency,  "Nationality" from tbl_players group by "Nationality" order by frequency desc limit 3;
--will show top 3 nationality. 

--Q4 What is the total wage given to all players? What's the average and standard deviation?

select sum("Wage") as total_wage, avg("Wage") as average_wage,round(stddev("Wage") )as std_wage from tbl_players;
--will show data type error varchar

alter table tbl_players
alter column "Wage" integer(50);

select sum("Wage") as total_wage, avg("Wage") as average_wage, STDDEV("Wage") as std_wage from tbl_players;
--now this will show the results


--Q5 Which player has the highest wage? Who has the lowest?

select max("Wage") from tbl_players
--will show highest wage

select "Name" from tbl_players where "Wage"=260
--will show the name of player with highest wage

select "Name" from tbl_players where "Wage"=(select max("Wage") from tbl_players);
--will show name of player with highest wage using sub query

select "Name" from tbl_players where "Wage"=(select min("Wage") from tbl_players);
--will show 4770 names with lowest wage


--Q6 The player having the best overall rating? Worst Overall rating?

select "Name" from tbl_players where "Overall"=(select max("Overall") from tbl_players);
--will show player with best overall rating

select "Name" from tbl_players where "Overall"=(select min("Overall") from tbl_players);
--will show player with worst overall rating


--Q7 Club having the highest total of overall rating? Highest Average of overall rating?

select sum("Overall") as total_rating, "Club" from tbl_players group by "Club"  order by total_rating desc;
--will show data type error varchar


select sum("Overall") as total_rating, "Club" from tbl_players group by "Club" order by total_rating desc;
--will now show the results. Highest rating-Real Madrid, FC Barcelona, Manchester United

select sum("Overall") as total_rating ,"Club" from tbl_players group by "Club" order by total_rating desc limit 3;
--will top 3 clubs based on total rating -Real Madrid, FC Barcelona, Manchester United

select  avg("Overall") as average_rating, "Club" from tbl_players group by "Club" order by average_rating desc  limit 3;
--will top 3 clubs based on total rating -Juventus, Napoli, Inter


--Q8 What are the top 5 clubs based on the average ratings of their players?

select  avg("Overall") as average_rating, "Club" from tbl_players group by "Club" order by average_rating desc limit 5;
--will top 3 clubs based on total rating -Juventus, Napoli, Inter, Real Madrid, FC Barcelona


--Q9 What is the distribution of players whose preferred foot is left vs right?

select count(*) as frequency, "Preferred Foot" from tbl_players group by "Preferred Foot" order by frequency desc;
--will show left and right foot distribution. In case of MySQL, numbers can be used instead of column name


--Q11 What is the frequency distribution of nationalities among players whose club name starts with M?

select count(*) as freq, "Nationality", "Club" from tbl_players where "Club" like 'M%' group by "Nationality", "Club";
--will show nationality frequency based on club name start with M









