-- Insert test data for Notes (Grades)
-- This data is loaded into the grading_service database
-- Each note references a student by student_id

INSERT INTO notes (student_id, matiere, valeur) VALUES
(1, 'Mathematics', 15.5),
(1, 'Physics', 16.0),
(1, 'Chemistry', 14.5),
(2, 'Mathematics', 18.0),
(2, 'Physics', 17.5),
(2, 'Chemistry', 16.0),
(3, 'Mathematics', 12.5),
(3, 'Physics', 13.0),
(3, 'Chemistry', 14.0),
(4, 'Mathematics', 19.0),
(4, 'Physics', 18.5),
(4, 'Chemistry', 17.5),
(5, 'Mathematics', 14.0),
(5, 'Physics', 15.5),
(5, 'Chemistry', 16.5),
(6, 'Mathematics', 16.5),
(6, 'Physics', 17.0),
(6, 'Chemistry', 15.5),
(7, 'Mathematics', 13.0),
(7, 'Physics', 12.5),
(7, 'Chemistry', 13.5);
