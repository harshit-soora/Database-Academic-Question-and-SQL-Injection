Student (RollNo int Not Null, Name varchar(20) Not Null, YearOfAdmission int Not Null,
PRIMARY KEY(RollNo))

Friend(OwnRoll int Not Null, FriendRoll int Not Null,
PRIMARY KEY(OwnRoll, FriendRoll),
FOREIGN KEY fk_std1(OwnRoll) REFERENCES Student(RollNo),
FOREIGN KEY fk_std2(FriendRoll) REFERENCES Student(RollNo))

Movie(MID int Not Null, Title varchar(30) Not Null, YearOfRelease int Not Null, DirectorName
varchar(20) Null,
PRIMARY KEY(MID)) 
"""[Assume all director names are unique. However, same director can direct
many movies]"""

Rating(RollNo int Not Null, MID int Not Null, RatingDate date Not Null, Rating int Not Null,
PRIMARY KEY(RollNo, MID, RatingDate),
FOREIGN KEY fk_std4(RollNo) REFERENCES Student(RollNo),
FOREIGN KEY fk_mov2(MID) REFERENCES Movie(MID));


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
(6, 104, '2011-04-01', 5),
(7, 101, '2011-01-01', 5),
(8, 102, '2011-02-01', 5),
(9, 103, '2011-03-01', 3),
(10, 104, '2011-01-01', 5),
(7, 105, '2011-02-01', 5),
(8, 105, '2011-03-01', 3);


-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
BONUS: 
"""List the students whose difference of ratings for the same movie 
on consecutive dates is greater than 1. (Output Format: RollNo, Name, 
Title, RatingDate1, Rating1, RatingDate2, Rating2). Note, if for the 
same movie, this happens more than once, you may either report that 
once or as many times as they occur. Also, for the same student, 
there might be multiple such movies."""


