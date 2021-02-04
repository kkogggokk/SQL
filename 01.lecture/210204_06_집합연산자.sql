/* **********************************************************************************************
���� ������ (���� ����)
- �� �̻��� select ����� ������ �ϴ� ����.
- ����
 select��  ���տ����� select�� [���տ����� select�� ...] [order by �����÷� ���Ĺ��]

-������
  - UNION: �� select ����� �ϳ��� �����Ѵ�. �� �ߺ��Ǵ� ���� �����Ѵ�. (������)
  - UNION ALL : �� select ����� �ϳ��� �����Ѵ�. �ߺ��Ǵ� ���� �����Ѵ�. (������)
  - INTERSECT: �� select ����� ������ ����ุ �����Ѵ�. (������)
  - MINUS: ���� ��ȸ������� ������ ��ȸ����� ���� �ุ �����Ѵ�. (������)
   
 - ��Ģ
  - ������ select ���� �÷� ���� ���ƾ� �Ѵ�. 
  - ������ select ���� �÷��� Ÿ���� ���ƾ� �Ѵ�.
  - ���� ����� �÷��̸��� ù��° select���� ���� ������.
  - order by ���� ������ �������� ���� �� �ִ�.
  - UNION ALL�� ������ ������ ������ �ߺ��Ǵ� ���� �����Ѵ�.
*************************************************************************************************/

select * from emp where dept_id in (10, 20, 30, 40)
union all 
select * from emp where salary > 15000;

-- emp ���̺��� salary �ִ밪�� salary �ּҰ�, salary ��հ� ��ȸ
select max(salary), min(salary), avg(salary) from emp;

select 'MAX' "Label", max(salary) "�޿�����" from emp -- 'MAX' ���� �ٿ�����. 
union all
select 'MIN', min(salary) from emp
union all
select 'AVG', round(avg(salary),2) from emp
order by 1; -- ���Ͽ� ��ü ����� ���� �����̴�. 



-- emp ���̺��� ������(emp.job_id) �޿� �հ�� ��ü ������ �޿��հ踦 ��ȸ.
select decode(grouping_id(job_id),0, job_id,' �Ѱ�') job_id, 
    sum(salary) 
from emp 
group by rollup(job_id);

-- ���Ͽ� ����ؼ� ��ȸ�غ��� 
select job_id, sum(salary) from emp
group by job_id
union all
select '�Ѱ�', sum(salary) from emp;

--�ѱ� ������ ���� ǰ�� ��ŷ
drop table export_rank;
create table export_rank(
    year char(4) not null,
    ranking number(2) not null,
    item varchar2(60) not null
);
insert into export_rank values(1990, 1, '�Ƿ�');
insert into export_rank values(1990, 2, '�ݵ�ü');
insert into export_rank values(1990, 3, '����');
insert into export_rank values(1990, 4, '������');
insert into export_rank values(1990, 5, '�����ؾ籸�����׺�ǰ');
insert into export_rank values(1990, 6, '��ǻ��');
insert into export_rank values(1990, 7, '������');
insert into export_rank values(1990, 8, 'ö����');
insert into export_rank values(1990, 9, '�����弶������');
insert into export_rank values(1990, 10, '�ڵ���');

insert into export_rank values(2000, 1, '�ݵ�ü');
insert into export_rank values(2000, 2, '��ǻ��');
insert into export_rank values(2000, 3, '�ڵ���');
insert into export_rank values(2000, 4, '������ǰ');
insert into export_rank values(2000, 5, '�����ؾ籸�����׺�ǰ');
insert into export_rank values(2000, 6, '������ű��');
insert into export_rank values(2000, 7, '�ռ�����');
insert into export_rank values(2000, 8, 'ö����');
insert into export_rank values(2000, 9, '�Ƿ�');
insert into export_rank values(2000, 10, '������');

insert into export_rank values(2018, 1, '�ݵ�ü');
insert into export_rank values(2018, 2, '������ǰ');
insert into export_rank values(2018, 3, '�ڵ���');
insert into export_rank values(2018, 4, '���ǵ��÷��̹׼���');
insert into export_rank values(2018, 5, '�ռ�����');
insert into export_rank values(2018, 6, '�ڵ�����ǰ');
insert into export_rank values(2018, 7, 'ö����');
insert into export_rank values(2018, 8, '�����ؾ籸�����׺�ǰ');
insert into export_rank values(2018, 9, '������ű��');
insert into export_rank values(2018, 10, '��ǻ��');

--�⵵�� ���� ǰ�� ��ŷ
drop table import_rank;
create table import_rank(
    year char(4) not null,
    ranking number(2) not null,
    item varchar2(60) not null
);
insert into import_rank values(1990, 1, '����');
insert into import_rank values(1990, 2, '�ݵ�ü');
insert into import_rank values(1990, 3, '������ǰ');
insert into import_rank values(1990, 4, '������ȭ�б��');
insert into import_rank values(1990, 5, '����');
insert into import_rank values(1990, 6, '��ǻ��');
insert into import_rank values(1990, 7, 'ö����');
insert into import_rank values(1990, 8, '�װ���׺�ǰ');
insert into import_rank values(1990, 9, '�����');
insert into import_rank values(1990, 10, '��������м���');

insert into import_rank values(2000, 1, '����');
insert into import_rank values(2000, 2, '�ݵ�ü');
insert into import_rank values(2000, 3, '��ǻ��');
insert into import_rank values(2000, 4, '������ǰ');
insert into import_rank values(2000, 5, 'õ������');
insert into import_rank values(2000, 6, '�ݵ�ü���������');
insert into import_rank values(2000, 7, '�����׹��');
insert into import_rank values(2000, 8, '������ű��');
insert into import_rank values(2000, 9, 'ö����');
insert into import_rank values(2000, 10, '����ȭ�п���');

insert into import_rank values(2018, 1, '����');
insert into import_rank values(2018, 2, '�ݵ�ü');
insert into import_rank values(2018, 3, 'õ������');
insert into import_rank values(2018, 4, '������ǰ');
insert into import_rank values(2018, 5, '�ݵ�ü���������');
insert into import_rank values(2018, 6, '��ź');
insert into import_rank values(2018, 7, '��ǻ��');
insert into import_rank values(2018, 8, '����ȭ�п���');
insert into import_rank values(2018, 9, '�ڵ���');
insert into import_rank values(2018, 10, '������ű��');

commit;


--TODO 1 :  2018��(year) ����(export_rank)�� ����(import_rank)�� ���ÿ� ������ ǰ��(item)�� ��ȸ
-- ���ʿ� �ִ� ��. intersect
-- result : 5 -  ������ű��,�ݵ�ü, ������ǰ, �ڵ���, ��ǻ��

select item from export_rank where year = 2018
intersect 
select item from import_rank where year = 2018;

--TODO 2 :  2018��(export_rank.year) �ֿ� ���� ǰ��(export_rank.item)�� 2000�⿡�� ���� ǰ�� ��ȸ
-- 2018-2000 
-- result : 2 - �ڵ�����ǰ. ���ǵ��÷��̹׼���

select item from export_rank where year = 2018
minus
select item from export_rank where year = 2000 order by 1;


--TODO 3 : 1990 ����(export_rank)�� ����(import_rank) ��ŷ�� ���Ե�  ǰ��(item)���� ���ļ� ��ȸ. �ߺ��� ǰ�� �������� ��ȸ
--union all
-- result: 20

select item from export_rank where year = 1990 --10 
union all 
select item from import_rank where year = 1990; --10

--TODO 4 : 1990 ����(export_rank)�� ����(import_rank) ��ŷ�� ���Ե�  ǰ��(item)���� ���ļ� ��ȸ. �ߺ��� ǰ���� �ȳ������� ��ȸ
--union
-- result : 17

select item from export_rank where year = 1990
union
select item from import_rank where year = 1990;

--TODO 5 : 1990��� 2018���� ���� �ֿ� ���� ǰ��(export_rank.item) ��ȸ
-- intersect
-- result : 5 - ������ű��, �ݵ�ü, ������ǰ, �ڵ���, ��ǻ��

select item from export_rank where year = 1990
intersect 
select item from export_rank where year = 2018;

--TODO 6 : 1990�� �ֿ� ���� ǰ��(export_rank.item)�� 2018��� 2000�⿡�� ���� ǰ�� ��ȸ
--1990 - 2018 - 2000
-- result : 3 ����, ������ , �����弶������

select item from export_rank where year = 1990
minus
select item from export_rank where year = 2018
minus
select item from export_rank where year = 2000;


--TODO 7 : 2000�� ����ǰ����(import_rank.item) 2018�⿡�� ���� ǰ���� ��ȸ.
-- 2000 - 2018
-- result : 3 �����׹��, ������ű��, ö����

select item from import_rank where year = 2000
minus 
select item from import_rank where year = 2018;


