## Description
score-card is a sample Rails application designed using Object Oriented Programming approach.

## Problem Statement
The class teacher of class VII has the scores of his class students in 4 subjects. Now he has to
make a couple of calculations to calculate if the student has scored above/below average
among the fellow students of the same grade. And also prepare a report based on this.

The grade system is as follows:

**Grade** - **(operator)** - **Total score**  
A >= 340  
340 > B >= 300  
C < 300

Now the teacher asks you to write a computer program to solve his problem. All he needs is :-
1. A scorecard for each student
  * with the grade he/she falls into.
  * is the student above or below average (average being, average of scores of all students in the
same grade).
2. Number of students in each grade
3. Number of students above their grade average.
4. Number of students below their grade average.

## Sample Input & Output

#### Input:

1,S1-90,S2-89,S3-78,S4-92  
2,S1-96,S2-69,S3-75,S4-60  
3,S1-80,S2-67,S3-80,S4-87  
4,S1-50,S2-90,S3-88,S4-52  

#### Output:

**Score card**

 ID | Subject 1 | Subject 2 | Subject 3 | Subject 4 | Grand-Total | Grade | Average-Compare |  
 01 |     90    |     89    |     78    |     92    |     349     |   A   |      BELOW      |  
 02 |     96    |     69    |     75    |     60    |     300     |   B   |      BELOW      |  
 03 |     80    |     67    |     80    |     87    |     314     |   B   |      ABOVE      |  
 04 |     50    |     90    |     88    |     52    |     280     |   C   |      BELOW      |  

----------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------
**Grade report**

Number of students in A Grade :: 1  
Number of students in B Grade :: 2  
Number of students in C Grade :: 1  
Number of students above their grade average :: 1  
Number of students below their grade average :: 3  

----------------------------------------------------------------------------------------------

## Dependencies
Ruby Version: ruby 2.6.6
Rails Version: Rails 6.0.3.6

## Run the code
From console run Student.get_student_report
Output is captured as csv under public/csv folder
Also output is printed in console