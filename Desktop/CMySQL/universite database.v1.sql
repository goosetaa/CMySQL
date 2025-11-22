




CREATE TABLE department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget NUMERIC(12,2)
);

CREATE TABLE instructor (
    ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50) REFERENCES department(dept_name),
    salary NUMERIC(12,2)
);

CREATE TABLE student (
    ID INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_name VARCHAR(50) REFERENCES department(dept_name),
    tot_cred INT
);

CREATE TABLE advisor (
    s_ID INT REFERENCES student(ID),
    i_ID INT REFERENCES instructor(ID),
    PRIMARY KEY (s_ID, i_ID)
);

CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_name VARCHAR(50) REFERENCES department(dept_name),
    credits INT
);

CREATE TABLE teaches (
    ID INT REFERENCES instructor(ID),
    course_id VARCHAR(10) REFERENCES course(course_id),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    PRIMARY KEY (ID, course_id, sec_id, semester, year)
);

CREATE TABLE takes (
    ID INT REFERENCES student(ID),
    course_id VARCHAR(10) REFERENCES course(course_id),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    grade CHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year)
);

CREATE TABLE classroom (
    building VARCHAR(50),
    room_number VARCHAR(10),
    capacity INT,
    PRIMARY KEY (building, room_number)
);

CREATE TABLE time_slot (
    time_slot_id VARCHAR(10),
    day VARCHAR(10),
    start_time TIME,
    end_time TIME,
    PRIMARY KEY (time_slot_id, day, start_time)
);

CREATE TABLE section (
    course_id VARCHAR(10) REFERENCES course(course_id),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    room_number VARCHAR(10),
    time_slot_id VARCHAR(10),
    day VARCHAR(10),
    start_time TIME,
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number),
    FOREIGN KEY (time_slot_id, day, start_time) REFERENCES time_slot(time_slot_id, day, start_time)
);

CREATE TABLE prereq (
    course_id VARCHAR(10) REFERENCES course(course_id),
    prereq_id VARCHAR(10) REFERENCES course(course_id),
    PRIMARY KEY (course_id, prereq_id)
);

INSERT INTO department (dept_name, building, budget) VALUES
('Computer Science', 'Engineering', 80000),
('Mathematics', 'Science', 50000),
('Physics', 'Newton', 60000);

INSERT INTO instructor (ID, name, dept_name, salary) VALUES
(1001, 'Dr. Smith', 'Computer Science', 90000),
(1002, 'Dr. Brown', 'Mathematics', 80000),
(1003, 'Dr. Green', 'Physics', 75000);

INSERT INTO student (ID, name, dept_name, tot_cred) VALUES
(2001, 'Ali', 'Computer Science', 30),
(2002, 'Ayşe', 'Mathematics', 45),
(2003, 'Mehmet', 'Physics', 60);

INSERT INTO advisor (s_ID, i_ID) VALUES
(2001, 1001),
(2002, 1002),
(2003, 1003);

INSERT INTO course (course_id, title, dept_name, credits) VALUES
('CS101', 'Intro to Programming', 'Computer Science', 4),
('CS102', 'Data Structures', 'Computer Science', 4),
('CS201', 'Algorithms', 'Computer Science', 4),
('CS301', 'Operating Systems', 'Computer Science', 4),
('MATH201', 'Calculus II', 'Mathematics', 3),
('MATH202', 'Linear Algebra', 'Mathematics', 3),
('PHYS150', 'General Physics', 'Physics', 4);

INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES
(1001, 'CS101', '1', 'Fall', 2024),
(1001, 'CS102', '1', 'Fall', 2024),
(1001, 'CS201', '1', 'Spring', 2025),
(1001, 'CS301', '1', 'Spring', 2025),
(1002, 'MATH201', '1', 'Fall', 2024),
(1002, 'MATH202', '1', 'Spring', 2025),
(1003, 'PHYS150', '1', 'Fall', 2024);

INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES
(2001, 'CS101', '1', 'Fall', 2024, 'A'),
(2001, 'CS102', '1', 'Fall', 2024, 'B'),
(2001, 'CS201', '1', 'Spring', 2025, 'A'),
(2002, 'MATH201', '1', 'Fall', 2024, 'B'),
(2002, 'MATH202', '1', 'Spring', 2025, 'A'),
(2003, 'PHYS150', '1', 'Fall', 2024, 'A');

INSERT INTO classroom (building, room_number, capacity) VALUES
('Engineering', '101', 60),
('Engineering', '102', 45),
('Science', '201', 40),
('Newton', '301', 75);

INSERT INTO time_slot (time_slot_id, day, start_time, end_time) VALUES
('TS1', 'Mon', '09:00', '10:30'),
('TS2', 'Tue', '11:00', '12:30'),
('TS3', 'Wed', '13:00', '14:30'),
('TS4', 'Thu', '15:00', '16:30');

INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id, day, start_time) VALUES
('CS101', '1', 'Fall', 2024, 'Engineering', '101', 'TS1', 'Mon', '09:00'),
('CS102', '1', 'Fall', 2024, 'Engineering', '102', 'TS2', 'Tue', '11:00'),
('CS201', '1', 'Spring', 2025, 'Engineering', '101', 'TS3', 'Wed', '13:00'),
('CS301', '1', 'Spring', 2025, 'Engineering', '102', 'TS4', 'Thu', '15:00'),
('MATH201', '1', 'Fall', 2024, 'Science', '201', 'TS2', 'Tue', '11:00'),
('MATH202', '1', 'Spring', 2025, 'Science', '201', 'TS3', 'Wed', '13:00'),
('PHYS150', '1', 'Fall', 2024, 'Newton', '301', 'TS4', 'Thu', '15:00');

INSERT INTO prereq (course_id, prereq_id) VALUES
('CS102', 'CS101'),
('CS201', 'CS102'),
('CS301', 'CS201'),
('MATH202', 'MATH201');



SELECT dept_name COUNT (course_id) AS ders_sayisi
FROM Course 
GROUP Course 
GROUP BY dept






SELECT dept_name, COUNT(course_id) AS ders_sayisi
FROM Course
GROUP BY dept_name
HAVING COUNT(course_id) > (
    SELECT COUNT(course_id)
    FROM Course
    WHERE dept_name = 'Computer Engineering'
);



