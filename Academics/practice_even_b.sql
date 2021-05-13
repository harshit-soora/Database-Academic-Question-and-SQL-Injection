-----------------------------------------------
-----------------------------------------------
-----------------------------------------------

6.
"""List the movies which have been given ratings by at least 4 students 
whose Year of Admission is after the Year of Release of the movie. 
(Output format: Title, YearOfRelease, Rollno, YearOfAdmission). 
Note, values for some of the columns may repeat for different rows."""

"""Find MID where rating is given by atleast 4 student"""
Select r.MID, r.Rollno, s.YearOfAdmission
from Rating as r, Student as s
where r.Rollno = s.Rollno 
group by r.MID
having count(r.Rollno) > 1

"""ERROR: this will only return one entry per MID"""
"""as we have grouped by the same"""


"""Try Join Operation, or creating new table from both student and Rating"""
Select m.MID, m.Title, m.YearOfRelease, s.Rollno, s.YearOfAdmission
from Rating as r 
left outer join Student as s on r.Rollno = s.Rollno
left outer join Movie as m on r.MID = m.MID
where m.YearOfRelease <  s.YearOfAdmission 
order by m.Title
;


"""Now delete the Movie with rating less than 4"""
Select r.MID
from Rating as r
group by r.MID
having count(r.Rollno) < 4


Select x.Title, x.YearOfRelease, x.Rollno, x.YearOfAdmission
from 
(
Select m.MID as MID, m.Title, m.YearOfRelease, s.Rollno, s.YearOfAdmission
from Rating as r 
left outer join Student as s on r.Rollno = s.Rollno
left outer join Movie as m on r.MID = m.MID
where m.YearOfRelease <  s.YearOfAdmission 
order by m.Title
) as x
where x.MID not in 
(
Select r.MID as MID
from Rating as r
group by r.MID
having count(r.Rollno) < 4	
)
order by x.Title


Select x.Title, x.YearOfRelease, x.Rollno, x.YearOfAdmission
from 
(
Select m.MID as MID, m.Title, m.YearOfRelease, s.Rollno, s.YearOfAdmission
from Rating as r 
left outer join Student as s on r.Rollno = s.Rollno
left outer join Movie as m on r.MID = m.MID
where m.YearOfRelease <  s.YearOfAdmission 
order by m.Title
) as x,
(
Select r.MID as MID
from Rating as r
group by r.MID
having count(r.Rollno) < 4	
) as y
where x.MID != y.MID
order by x.Title


"""Above Both are correct"""




-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
7.
"""List the students whose average rating over all movies 
(including multiple instances of rating the movies on different dates) 
is less than the average rating of those movies by his/her friends 
(including multiple instances of rating the movies on different dates). 
(Output format: RollNo1, AverageRating1, RollNo2, AverageRating2)"""

"""delete a new entry""" 
"""to see if 0 is considered"""
delete from Rating
where Rollno = 10;


"""Fing average rating by each roll no"""
Select r.Rollno, avg(r.Rating) as average
from Rating as r 
group by r.Rollno


"""Friend List : Consider (1, 2) & (2, 1) both"""
Select * from Friend 
union 
(
Select f.FriendRoll, f.OwnRoll from Friend as f
)
order by OwnRoll


"""Now club it with friends"""
Select x.OwnRoll as RollNo1, l1.average as AverageRating1,
x.FriendRoll as RollNo2, l2.average as AverageRating2
from 
(
Select * from Friend 
union 
(
Select f.FriendRoll, f.OwnRoll from Friend as f
)
order by OwnRoll
) as x,
(
Select r.Rollno, avg(r.Rating) as average
from Rating as r 
group by r.Rollno
) as l1,
(
Select r.Rollno, avg(r.Rating) as average
from Rating as r 
group by r.Rollno
) as l2
where l1.Rollno = x.OwnRoll and l2.Rollno = x.FriendRoll
and l1.average > l2.average 

"""ONLY DOWNSIGHT HERE IS you didn't consider friends with zero average"""


"""Now the Answer"""
----
https://stackoverflow.com/questions/67514627/consider-average-rating-as-zero-in-case-that-roll-no-is-not-in-the-rating-list-i
----




-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
8.
"""
List the 4 th most popular movies(s). (Output format: Title, 
NumberOfStudentRatings). Note, upto the 3 rd most popular movie, 
all movies having the same popularity will have to be counted only once.
For the 4 th position, all movies having that popularity are to be listed.
"""


-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
9. 
"""List the students who have not rated any movie that have been rated 
by his/her friend. (Output Format: RollNo1, Name1, RollNo2, Name2)"""



-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
10. 
"""List the top 4 most popular movies. (Output format: Title, 
NumberOfStudentRatings). Note, popularity is determined by the number 
of ratings received a movie, which is the number of distinct students 
who have rated the movie. Also, here the number 4 denotes 4 distinct values 
of popularity with possibly multiple movies having the same popularity."""