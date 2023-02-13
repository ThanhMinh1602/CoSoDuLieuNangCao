--1. view 1 :Hiển thị tên  và mức lương của những nhân viên làm  25 năm trở lên 
DELIMITER $$
CREATE VIEW view1 AS
    SELECT first_name ,
    last_name,
    salary
    FROM employees 
    where datediff (now(), hire_date) >= 25*365


--2. view 2 : Hiển thị thông tin cá nhân của tất cả nhân viên với department_id >= 5
    DELIMITER $$
    CREATE VIEW view2 AS
    SELECT employee_id ,
	first_name ,
	last_name ,
	email ,
	phone_number 
    FROM employees where department_id >= 5


--3. Tạo một thủ tục có tên proc_Salary để xét thưởng cuối năm như sau 
-- nếu nhân viên làm trên: >= 35 năm thưởng lương 20tr
-- nếu làm trên 30 năm thưởng 15 tr
-- nếu làm trên 25 năm thưởng 10 tr 
-- còn lại thưởng 5 tr
DELIMITER $$
create procedure pro_salary ()
BEGIN
   select e.employee_id, e.first_name, e.last_name, e.hire_date,
   case 
   when datediff (now(), e.hire_date) >= 35*365 then e.salary + 20000000
   when datediff (now(), e.hire_date) >= 30*365 then e.salary + 15000000
   when datediff (now(), e.hire_date) >= 25*365 then e.salary + 10000000
   else e.salary + 5000000
   end as 'Thuong cuoi nam'
   from employees as e;
END; $$
-- goi thu tuc
call pro_Salary


--4. Tạo một pro_Search_Name(Fistname)
-- sau đó cho hiển thị toàn bộ thông tin của nhân viên đó
-- trong đó nối Fullname Firstname+ Lastname
DELIMITER $$
create procedure pro_search_name (IN firstname varchar(20))
begin
	select employee_id,concat(first_name,' ',last_name) as fullname, email, phone_number, hire_date,
	job_id,salary,manager_id,department_id from employees where first_name like concat('%',firstname,'%');
end;$$
call pro_search_name('steven')



        