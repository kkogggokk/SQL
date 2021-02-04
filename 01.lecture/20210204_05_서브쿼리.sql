/* **************************************************************************
��������(Sub Query)
- �����ȿ��� select ������ ����ϴ� ��.
- ���� ���� - ��������

���������� ���Ǵ� ��
 - select��, from��, where��, having��
 
���������� ����
- ��� ������ ���Ǿ������� ���� ����
    - ��Į�� �������� - select ���� ���. �ݵ�� �������� ����� 1�� 1��(�� �ϳ�-��Į��) 0���� ��ȸ�Ǹ� null�� ��ȯ
    - �ζ��� �� - from ���� ���Ǿ� ���̺��� ������ �Ѵ�.
�������� ��ȸ��� ����� ���� ����
    - ������ �������� - ���������� ��ȸ��� ���� ������ ��.
    - ������ �������� - ���������� ��ȸ��� ���� �������� ��.
���� ��Ŀ� ���� ����
    - ����(�񿬰�) �������� - ���������� ���������� �÷��� ������ �ʴ´�. ���������� ����� ���� ���������� �����ϴ� ������ �Ѵ�.
    - ���(����) �������� - ������������ ���������� �÷��� ����Ѵ�. 
                            ���������� ���� ����Ǿ� ������ �����͸� ������������ ������ �´��� Ȯ���ϰ��� �Ҷ� �ַ� ����Ѵ�.

- ���������� �ݵ�� ( ) �� ������� �Ѵ�.
************************************************************************** */
--������ ��������

-- ����_ID(emp.emp_id)�� 120���� ������ ���� ����(emp.job_id)���� 
-- ������ id(emp_id),�̸�(emp.emp_name), ����(emp.job_id), �޿�(emp.salary) ��ȸ



-- ����_id(emp.emp_id)�� 115���� ������ ���� ����(emp.job_id)�� �ϰ� ���� �μ�(emp.dept_id)�� ���� �������� ��ȸ�Ͻÿ�.




-- ������ �� �޿�(emp.salary)�� ��ü ������ ��� �޿����� ���� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ��ȸ. �޿�(emp.salary) �������� ����.




-- ��ü ������ ��� �޿�(emp.salary) �̻��� �޴� �μ���  �̸�(dept.dept_name), �Ҽ��������� ��� �޿�(emp.salary) ���. 
-- ��ձ޿��� �Ҽ��� 2�ڸ����� ������ ��ȭǥ��($)�� ���� ������ ���




-- TODO: ������ ID(emp.emp_id)�� 145�� �������� ���� ������ �޴� �������� �̸�(emp.emp_name)�� �޿�(emp.salary) ��ȸ.
-- �޿��� ū ������� ��ȸ

--����� Ǯ��
select emp_name, salary
from emp
where salary > (select salary from emp where emp_id = 145)
order by salary;


-- TODO: ������ ID(emp.emp_id)�� 150�� ������ ���� ����(emp.job_id)�� �ϰ� ���� ���(emp.mgr_id)�� ���� �������� 
-- id(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), ���(emp.mgr_id) �� ��ȸ

--����� Ǯ�� 
select emp_id, emp_name, job_id, mgr_id
from emp 
where (job_id, mgr_id) = (select job_id, mgr_id from emp where emp_id = 150) ;

-- TODO : EMP ���̺��� ���� �̸���(emp.emp_name)��  'John'�� ������ �߿��� �޿�(emp.salary)�� ���� ���� ������ salary(emp.salary)���� ���� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.

-- ����� Ǯ�� 
select emp_id, emp_name, salary 
from emp
where salary > (select max(salary) from emp where emp_name = 'John') 
order by salary;

select emp_id, emp_name, salary 
from emp
where salary > all(select salary from emp where emp_name = 'John') 
order by salary;

-- TODO: �޿�(emp.salary)�� ���� ���� ������ ���� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ.

select d.dept_name, d.loc
from emp e left join dept d on e.dept_id = d.dept_id
where e.salary = (select max(salary) from emp);


-- TODO: �޿�(emp.salary)�� ���� ���� �޴� �������� �̸�(emp.emp_name), �μ���(dept.dept_name), �޿�(emp.salary) ��ȸ. 
--       �޿��� �տ� $�� ���̰� ���������� , �� ���

select e.emp_name, d.dept_name, to_char(e.salary,'fm$999,999') "�޿�"
from emp e left join dept d on e.dept_id = d.dept_id 
where e.salary = (select max(salary) from emp);


-- TODO: ��� ����ID(emp.job_id) �� 'ST_CLERK'�� �������� ��� �޿����� ���� �޿��� �޴� �������� ��� ������ ��ȸ. 
-- �� ���� ID�� 'ST_CLERK'�� �ƴ� �����鸸 ��ȸ. 
-- result : 21
-- check ! 

select *  
from emp
where salary < (select avg(salary) from emp where job_id= 'ST_CLERK')
and (job_id <> 'ST_CLECK' or job_id is null)  --�켱������ Ȯ���ؾ� �Ѵ�. 
order by salary desc;

select *  
from emp
where salary < (select avg(salary) from emp where job_id= 'ST_CLERK')
and nvl(job_id,'�̹�ġ') <> 'ST_CLECK'
order by salary desc;

-- null <> 'ST_CLERK' -- null�� is, is not null �̷��� �����ؾ� �Ѵ�. 
-- job_id�� null�̰ų� sT_CLECK�� �ƴ� ���� �߿��� 

-- TODO: 30�� �μ�(emp.dept_id) �� ��� �޿�(emp.salary)���� �޿��� ���� �������� ��� ������ ��ȸ.
-- result : 59 

select * 
from emp 
where salary > (select avg(salary) from emp where dept_id = 30) 
order by salary;


-- TODO: EMP ���̺��� ����(emp.job_id)�� 'IT_PROG' �� �������� ��� �޿� �̻��� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� �޿� ������������ ��ȸ.

select emp_id, emp_name, salary 
from emp
where salary > (select avg(salary) from emp where job_id = 'IT_PROG')
order by salary desc;


-- TODO: 'IT' �μ�(dept.dept_name)�� �ִ� �޿����� ���� �޴� ������ 
-- ID(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date), �μ� ID(emp.dept_id), �޿�(emp.salary) ��ȸ
-- �Ի����� "yyyy�� mm�� dd��" �������� ���
-- �޿��� �տ� $�� ���̰� ���������� , �� ���
-- result : 24 

select emp_id, emp_name, to_char(hire_date,'yyyy"��" mm"��" dd"��"') hire_date, to_char(salary,'fm$99,999') salary
from emp e 
where salary > (select max(e.salary) from emp e join dept d on e.dept_id = d.dept_id where d.dept_name = 'IT') 
order by salary;


/* ----------------------------------------------
 ������ ��������
 - ���������� ��ȸ ����� �������� ���
 - where�� ������ ������
	- in
	- �񱳿����� any : ��ȸ�� ���� �� �ϳ��� ���̸� �� (where �÷� > any(��������) )
	- �񱳿����� all : ��ȸ�� ���� ��ο� ���̸� �� (where �÷� > all(��������) )
------------------------------------------------*/
--'Alexander' �� �̸�(emp.emp_name)�� ���� ������(emp.mgr_id)�� 
-- ���� �������� ID(emp_id), �̸�(emp_name), ����(job_id), �Ի�⵵(hire_date-�⵵�����), �޿�(salary)�� ��ȸ
-- �޿��� �տ� $�� ���̰� ���������� , �� ���


-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ ���� �޿�(emp.salary)�� ���� �޴� ������ ��� ������ ��ȸ.



-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ �� �޿��� ���� ���� �������� �޿��� ���� �޴� ������ ��� ������ ��ȸ.



-- TODO : �μ� ��ġ(dept.loc) �� 'New York'�� �μ��� �Ҽӵ� ������ ID(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id) �� sub query�� �̿��� ��ȸ.
--result : 37 

--����� Ǯ�� 
select emp_id, emp_name, dept_id 
from emp 
where dept_id in (select dept_id from dept where loc = 'New York');


-- TODO : �ִ� �޿�(job.max_salary)�� 6000������ ������ ����ϴ� ����(emp)�� ��� ������ sub query�� �̿��� ��ȸ.
-- result : 39 
-- ����� Ǯ�� 
select * from emp
where job_id in (select job_id from job where max_salary <= 6000);

-- TODO: �μ�_ID(emp.dept_id)�� 20�� �μ��� ������ ���� �޿�(emp.salary)�� ���� �޴� �������� ������  sub query�� �̿��� ��ȸ.
-- result : 5 

--�����
select * from emp 
-- where salary > all(select salary from emp where dept_id = 20);
where salary > (select max(salary) from emp where dept_id = 20);

-- TODO: �μ��� �޿��� ����� ���� ���� �μ��� ��� �޿����� ���� ���� �޴� �������� �̸�, �޿�, ������ sub query�� �̿��� ��ȸ
--result : 71 

select emp_name,job_id, salary
from emp 
--where salary > (select min(avg(salary)) from emp group by dept_id) ; 
where salary > any(select avg(salary) from emp group by dept_id);




-- TODO: ���� id(job_id)�� 'SA_REP' �� �������� ���� ���� �޿��� �޴� �������� ���� �޿��� �޴� �������� �̸�(emp_name), �޿�(salary), ����(job_id) �� sub query�� �̿��� ��ȸ.
-- result : 9

select emp_name, salary, job_id
from emp 
--where salary > all(select salary from emp where job_id = 'SA_REP');
where salary > (select max(salary) from emp where job_id = 'SA_REP');


/* ****************************************************************
���(����) ����
������������ ��ȸ���� ���������� ���ǿ��� ����ϴ� ����.
���������� �����ϰ� �� ����� �������� ���������� �������� ���Ѵ�.
* ****************************************************************/
-- �� �μ�����(DEPT) �޿�(emp.salary)�� ���� ���� �޴� �������� id(emp.emp_id), �̸�(emp.emp_name), ����(emp.salary), �ҼӺμ�ID(dept.dept_id) ��ȸ




/* ******************************************************************************************************************
EXISTS, NOT EXISTS ������ (���(����)������ ���� ���ȴ�)
-- ���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� ����. ������ �����ϴ� ���� �������� ���ุ ������ ���̻� �˻����� �ʴ´�.
-- �÷����� ������ �ʴ´�. 

Transacstion ���̺� 
-- ���� ���̺��� ������ ���̺��� ���� �����ǰ� �ִ��� (exists) ������(not exists) 
-- ���߿� (�ѹ� �̻�) �ֹ��� ��
**********************************************************************************************************************/


-- ������ �Ѹ��̻� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
-- join�� ���� �ʰ� ������ �ۼ��غ���. / �����ϰ� exists ������ ���̴�? 
-- result : 11 

select d.dept_id, d.dept_name, d.loc
from dept d 
where EXISTS (select * from emp e where e.dept_id = d.dept_id) -- exists���� �������� ����Ʈ �÷����� �߿����� �ʴ�. �ִ��� ������ ���� Ȯ�� 
order by 1; 

select DISTINCT dept_id from emp order by 1;

select * from dept where dept_id in (select distinct dept_id from emp);
-- ��exists�� �ִ��� ������ ���θ� Ȯ���Ϸ��� ������ �� ���� ���� Ȯ�� ���� ���ص� �Ǵ� Ȯ�εǸ� pass . 


-- ������ �Ѹ� ���� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
--result : 16 

select d.dept_id, d.dept_name, d.loc
from dept d 
where not EXISTS (select * from emp e where e.dept_id = d.dept_id);

-- �μ�(dept)���� ����(emp.salary)�� 13000�̻��� �Ѹ��̶� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
-- result : 3

select * 
from dept d 
where EXISTS (select * from emp e where d.dept_id = e.dept_id and salary >= 13000);

select * from emp where salary >= 13000;

/* ******************************
�ֹ� ���� ���̺�� �̿�.
******************************* */

--TODO1 : ��(customers) �� �ֹ�(orders)�� �ѹ� �̻� �� ������ ��ȸ.
-- result : 6 
-- ����Ǯ��
select * 
from customers c 
where EXISTS (select * from orders o where o.cust_id = c.cust_id);

-- select DISTINCT cust_id from orders ;

--TODO2 : ��(customers) �� �ֹ�(orders)�� �ѹ��� ���� ���� ������ ��ȸ.
-- result : 3 

--����Ǯ��
select * 
from customers c 
where not EXISTS (select * from orders o where o.cust_id = c.cust_id);

select count(*) coust_id from customers; -- �� 9�� - �ֹ���(6��) = 3 

--TODO3 : ��ǰ(products) �� �ѹ��̻� �ֹ��� ��ǰ ���� ��ȸ
-- result : 9

--���� Ǯ��
select * 
from products p
where EXISTS (select * from order_items oi where p.product_id = oi.product_id);
--Ȯ���غ��� 

select count(*) from products; -- 14 
select DISTINCT product_id from order_items; --9 


--TODO4 : ��ǰ(products)�� �ֹ��� �ѹ��� �ȵ� ��ǰ ���� ��ȸ
-- result : 5

-- ����Ǯ��
select * 
from products p 
where not exists(select * from order_items oi where p.product_id = oi.product_id);


