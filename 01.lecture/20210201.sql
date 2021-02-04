-- ������(job) �������� ��ȸ, �������� ���� �ͺ��� ���� 
select job, count(*) from emp group by job order by 2 desc;

-- �μ���(dept_name) ����(job) �� ������, �ְ�޿�(salary)�� ��ȸ, �μ��̸����� �������� ���� 
--select dept_name, job, count(*) from group by dept_name, job order by 1;

-- emp���̺��� �Ի翬����(hire_data) �� �޿�(salary)�� �հ��� ��ȸ. 
-- �޿� �հ�� �ڸ�������, �� �����õ� 

select to_char(hire_date,'yyyy') �Ի�⵵,
    to_char(sum(salary),'fm9,999,999') �޿��հ�,
from emp 
group by to_char(hire_date, 'yyyy'); 

-- ������ �Ի�⵵ �� ��� �޿��� ��ȸ
select job, extract(year from hire_date) "�Ի�⵵", 
    round(avg(salary),2) "��ձ޿�"
from emp
group by job, extract(year from hire_date)
order by 1;

-- �μ���(dept_name) ������ ��ȸ�ϴ� �� �μ���(dept_name)�� null�ΰ��� �����ϰ� ��ȸ.
select dept_name, count(*)
from emp
where dept_name is not null 
group by dept_name;

-- �޿� ������ �������� ���, �޿� ������ 5000 �̸�, 5000�̻� 10000 �̸�, 10000�̻� 20000�̸�, 20000 �̻� 
select case when salary < 5000 then '1���'
                when salary between 5000 and 9999.99 then '2���' 
                when salary between 10000 and 19999.99 then '3���' 
                else '4���' end as '�޿����' ,
        count(*)
from emp
group by case when salary < 5000 then '1���'
                when salary between 5000 and 9999.99 then '2���' 
                when salary between 10000 and 19999.99 then '3���' 
                else '4���' end
order by 1 ; 










































