-----------------------------------------------
-----------------------------------------------
-----------------------------------------------

6.
"""List the movies which have been given ratings by at least 4 students 
whose Year of Admission is after the Year of Release of the movie. 
(Output format: Title, YearOfRelease, Rollno, YearOfAdmission). 
Note, values for some of the columns may repeat for different rows."""

"""Need to add some more rows to table Rating"""
insert into Rating values
(7, 101, '2011-01-01', 5),
(8, 102, '2011-02-01', 5),
(9, 103, '2011-03-01', 3),
(10, 104, '2011-01-01', 5),
(7, 105, '2011-02-01', 5),
(8, 105, '2011-03-01', 3);


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
