create table employees(
	emp_no INT NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(30) NOT NULL,
	hire_date VARCHAR(30) NOT NULL,
	primary key (emp_no)
);


COPY employees from 'C:\Program Files\PostgreSQL\12\BC_Data/employees.csv'
with (format csv, header);

select * from employees

CREATE TABLE departments (
	dept_no VARCHAR(30) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY (dept_no)
);

COPY departments from 'C:\Program Files\PostgreSQL\12\BC_Data/departments.csv'
with (format csv, header);

select * from departments

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(30) NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

COPY dept_emp from 'C:\Program Files\PostgreSQL\12\BC_Data/dept_emp.csv'
with (format csv, header);

select * from dept_emp

CREATE TABLE dept_manager(
	dept_no VARCHAR(30) NOT NULL,
	emp_no INT NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

COPY dept_manager from 'C:\Program Files\PostgreSQL\12\BC_Data/dept_manager.csv'
with (format csv, header);

select * from dept_manager

CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY salaries from 'C:\Program Files\PostgreSQL\12\BC_Data/salaries.csv'
with (format csv, header);

select * from salaries

CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR(30) NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL,
	PRIMARY KEY (emp_no, title, from_date),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY titles from 'C:\Program Files\PostgreSQL\12\BC_Data/titles.csv'
with (format csv, header);

select * from titles

SELECT * FROM employees;
SELECT * FROM salaries;
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s
ON s.emp_no = e.emp_no;

SELECT * FROM employees;
SELECT hire_date FROM employees
WHERE hire_date LIKE '1986%';

SELECT * FROM dept_manager; 
SELECT * FROM employees;  
SELECT * FROM departments; 
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date 
FROM dept_manager AS dm
JOIN departments AS d
ON d.dept_no = dm.dept_no
JOIN employees AS e
ON e.emp_no = dm.emp_no;

SELECT first_name, last_name FROM employees
WHERE first_name = 'Hercules' and last_name like 'B%';

SELECT e.emp_no, e.last_name, e.first_name, d.dept_no
FROM employees AS e
INNER JOIN dept_emp AS d
ON e.emp_no = d.emp_no
WHERE d.dept_no = 'd002'

SELECT e.emp_no, e.last_name, e.first_name, d.dept_no
FROM employees AS e
INNER JOIN dept_emp AS d
ON e.emp_no = d.emp_no
WHERE d.dept_no = 'd002'OR d.dept_no = 'd005'

SELECT e.emp_no, e.last_name, e.first_name, d.dept_no, c.dept_name, c.dept_no
FROM employees AS e
INNER JOIN dept_emp AS d
ON e.emp_no = d.emp_no
INNER JOIN departments AS c
ON d.dept_no = c.dept_no
WHERE c.dept_name = 'Finance' OR c.dept_name = 'Development';

SELECT last_name AS "Last_name",
COUNT(last_name) AS "Frequency"
FROM employees 
GROUP BY last_name
ORDER BY
COUNT (last_name) DESC;