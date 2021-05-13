insert into Student values 
(1, "Ram", 2011),
(2, "Shyam", 2011),
(3, "Rakesh", 2011),
(4, "Ramesh", 2012),
(5, "Sanju", 2012),
(6, "Subhita", 2013),
(7, "Bali", 2014),
(8, "Sami", 2014),
(9, "Ruvi", 2014),
(10, "Ramdutt", 2015);

insert into Friend values
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(6, 7),
(7, 4),
(7, 8),
(9, 10);


insert into Movie values
(101, "Tere Naam", 2000, "AB"),
(102, "Mere Naam", 2001, "AB"),
(103, "Sabke Naam", 2002, "AB"),
(104, "Tere Sathi", 2000, "CC"),
(105, "Mere Sathi", 2001, "CC"),
(106, "Main Diwana", 2001, "DK"),
(107, "Dil Diwana", 2003, "EC");

insert into Rating values
(1, 101, '2011-01-01', 5),
(1, 102, '2011-02-01', 5),
(1, 103, '2011-03-01', 3),
(1, 104, '2011-04-01', 4),
(2, 101, '2011-01-01', 4),
(2, 102, '2011-02-01', 4),
(3, 103, '2011-03-01', 5),
(3, 104, '2011-04-01', 3),
(4, 101, '2011-01-01', 3),
(5, 102, '2011-02-01', 5),
(6, 103, '2011-03-01', 5),
(6, 104, '2011-04-01', 5);



-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
1. 
"""List the Rollno, Name, YearOfAdmission of all students who do 
not have even one friend having Ram as part of his name. 
(Output format: RollNo, Name, YearOfAdmission)"""

"""WON'T WORK"""
Select distinct S1.RollNo, S1.Name, S1.YearOfAdmission 
from Student as S1, Friend as F, Student as S2
where S1.Rollno = F.OwnRoll and F.FriendRoll = S2.RollNo  and S2.Name not like "%Ram%";


"""Check These Out First"""

"""If it is a two sided relation
A Friend with  B means B Friend with A"""

select * from Student 
left outer join Friend 
on Student.Rollno = Friend.OwnRoll or Student.Rollno = Friend.FriendRoll;

"""If it is single sideed relation"""
select * from Student 
left outer join Friend on Student.Rollno = Friend.OwnRoll;

select distinct a.Rollno, a.Name, a.YearOfAdmission
from (select * from Student 
left outer join Friend 
on Student.Rollno = Friend.OwnRoll or Student.Rollno = Friend.FriendRoll) as a


"""This Will not Work as MySQL don't support EXCEPT & INTERSECT"""
(Select * from Student )
except
(Select distinct S1.RollNo, S1.Name, S1.YearOfAdmission 
from Student as S1, Friend as F, Student as S2
where S1.Rollno = F.OwnRoll and F.FriendRoll = S2.RollNo  and S2.Name like "%Ram%");


"""ANSWER"""
Select * from Student
where Student.Rollno not in 
(Select distinct S1.RollNo
from Student as S1, Friend as F, Student as S2
where S1.Rollno = F.OwnRoll and F.FriendRoll = S2.RollNo  and S2.Name like "%Ram%");


Yeahhh !!



-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
2.
"""
List the titles of all movies that have received ratings from 
at least one student. (Output format:Title)
"""

Select m.Title as Title
from Movie as m
where m.MID in 
(Select distinct r.MID
from Rating as r);



-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
3.
"""
List the director names with their corresponding lowest rated movie(s) 
(Output format:DirectorName, Title, LowestTotalRating). Note, total rating 
of a movie is the sum of all the ratings it has received.
"""


"""Try this first"""
Select distinct r.MID, min(r.Rating) as Rating
from Rating as r
group by r.MID


"""Now make it complex(Minimium Rating)"""
Select m.DirectorName, m.Title, r.Rating, m.MID
from Movie as m, Rating as r
where (m.MID, r.Rating) in 
(Select distinct r.MID, min(r.Rating) as Rating
from Rating as r
group by r.MID
)
and m.MID = r.MID
order by m.MID;


"""Now make it complex(Minimium Total Rating)"""
Select m.DirectorName, m.Title, sum(r.Rating)
from Rating as r, Movie as m
where m.MID = r.MID
group by r.MID


""" Now find the director """
Select * 
from
(
Select m.DirectorName, m.Title, sum(r.Rating)
from Rating as r, Movie as m
where m.MID = r.MID
group by r.MID
) as t
group by t.DirectorName;



-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
4.
"""List the pair of students with their names who have rated the same movie(s)
at least once with the same rating (Output format: RollNo1, Name1, RollNo2, 
Name2, Title, Rating). Note, it is OK if the same pair of students shows 
up twice in the result set with their RollNo reversed."""


"""Try to find RollNo1 RollNo2 MID and Rating"""
"""Cartesian Product or Inner Join is an option""" 

Select * 
from Rating as r1 inner join Rating as r2 
on r1.MID = r2.MID and r1.Rating = r2.Rating and r1.Rollno != r2.Rollno


"""Without Join"""
Select r1.Rollno as RollNo1, r2.Rollno as RollNo2, r1.Rating as Rating, r1.MID as MID
from Rating as r1 inner join Rating as r2 
where r1.MID = r2.MID and r1.Rating = r2.Rating and r1.Rollno != r2.Rollno


"""Now Dive into the Problem"""
Select r.RollNo1, s1.Name as Name1, r.RollNo2, s2.Name as Name2, m.Title, r.Rating
from Student as s1, Student as s2, Movie as m,
(
Select r1.Rollno as RollNo1, r2.Rollno as RollNo2, r1.Rating as Rating, r1.MID as MID
from Rating as r1 inner join Rating as r2 
where r1.MID = r2.MID and r1.Rating = r2.Rating and r1.Rollno != r2.Rollno
) as r 
where r.RollNo1 = s1.Rollno and r.RollNo2 = s2.Rollno and r.MID =  m.MID



-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
5.
"""Determine is the average number of friends per student. (Output format: AvgNo). 
Note, your result should be just one row and one column which is the average of 
the number of friends each student has."""

""" Frist Find the number of friends per Student """
"""Do a union"""
"""This way we consider 1--2 && 2--1"""
Select * 
from Friend as f1
union
(Select f2.FriendRoll, f2.OwnRoll 
from Friend as f2) 


"""Find Average in above"""
Select t.OwnRoll, count(t.FriendRoll) as num
from
(
Select * 
from Friend as f1
union
(Select f2.FriendRoll, f2.OwnRoll 
from Friend as f2) 
) as t
group by t.OwnRoll;


"""Find Answer"""
Select avg(q.num)
from 
(
Select t.OwnRoll, count(t.FriendRoll) as num
from
(
Select * 
from Friend as f1
union
(Select f2.FriendRoll, f2.OwnRoll 
from Friend as f2) 
) as t
group by t.OwnRoll
) as q
;
