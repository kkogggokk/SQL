/*
1. ��ǰ ���̺��� ��ǰ_ID �÷��� [Primary key] �÷����� �� ���� �ٸ� ��� �ĺ��� �� ���ȴ�.
2. ��ǰ ���̺��� ������ �÷��� Not Null(NN) �� ������ ���� [null] �� ������ ���� ����.
3. �� ���̺��� �ٸ���� �ĺ��� �� ����ϴ� �÷��� [��_ID(cust_id)] �̴�. 
4. �� ���̺��� ��ȭ��ȣ �÷��� ������ Ÿ���� [vachar2] ���� [���ڿ�]������ �� [15]����Ʈ ������ �� ������ NULL ���� [����Ѵ�].
5. �� ���̺��� ������ �÷��� ���� 4�� ó�� ������ ���ÿ�.
    [DATE Ÿ������ ��¥�� �ð��� ����]
6. �ֹ� ���̺��� �� 5�� �÷��� �ִ�. ���� Ÿ���� [3]���̰� ���ڿ� Ÿ���� [1]�� �̰� ��¥ Ÿ���� [1]���̴�.
7. �� ���̺�� �ֹ����̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ����̺��� [��(customers] �̰� �ڽ� ���̺��� [�ֹ�(orders)]�̴�.
    �θ����̺��� [��_id(cust_id),PK]�÷��� �ڽ����̺��� [��_id(cust_id_,FK]�÷��� �����ϰ� �ִ�.
    �����̺��� ������ �����ʹ� �ֹ����̺��� [0~N] ��� ���谡 ���� �� �ִ�.
    �ֹ����̺��� ������ �����̺��� [1] ��� ���谡 ���� �� �ִ�.
8. �ֹ� ���̺�� �ֹ�_��ǰ ���̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ� ���̺��� [�ֹ�(orders)] �̰� �ڽ� ���̺��� [�ֹ�_��ǰ(order_items)]�̴�.
    �θ� ���̺��� _______________�÷��� �ڽ� ���̺��� ___________________�÷��� �����ϰ� �ִ�.
    �ֹ� ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� [0~N] ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ �ֹ� ���̺��� [1]��� ���谡 ���� �� �ִ�.
9. ��ǰ�� �ֹ�_��ǰ�� ���� ���谡 �ִ� ���̺��Դϴ�. 
    �θ� ���̺��� ___________________ �̰� �ڽ� ���̺��� ________________�̴�.
    �θ� ���̺��� _______________�÷��� �ڽ� ���̺��� ___________________�÷��� �����ϰ� �ִ�.
    ��ǰ ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� _________________ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ ��ǰ ���̺��� __________________��� ���谡 ���� �� �ִ�.
*/

-- TODO: 4���� ���̺� � ������ �ִ��� Ȯ��.

select * from customers;
select * from orders;
select * from order_imtes;
select * from product;

select *
from order_items i
    inner join products p on i.product_id = p.product_id
    inner join orders o on i.order_id = o.order_id
    inner join customers c on o.cust_id = c.cust_id
;

-- TODO: �ֹ� ��ȣ�� 1�� �ֹ��� �ֹ��� �̸�, �ּ�, �����ȣ, ��ȭ��ȣ ��ȸ
-- result : 1

select c.cust_name, c.address, c.postal_code, c.phone_number 
from customers c inner join orders o on c.cust_id = o.cust_id
where o.order_id = 1 ;

-- TODO : �ֹ� ��ȣ�� 2�� �ֹ��� �ֹ���, �ֹ�����, �ѱݾ�, �ֹ��� �̸�, �ֹ��� �̸��� �ּ� ��ȸ
-- result : 1

select o.order_date,o.order_status, o.order_total, c.cust_name, c.cust_email
from customers c inner join orders o on c.cust_id = o.cust_id
where order_id = 2;

-- TODO : �� ID�� 120�� ���� �̸�, ����, �����ϰ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ѱݾ��� ��ȸ
-- result : 2
-- CHECK : outter join

select c.cust_name, c.gender, c.join_date, o.order_id, o.order_date, o.order_total
from customers c left join orders o on c.cust_id = o.cust_id
where o.cust_id = 120;

-- oracle 
select c.cust_name, c.gender, c.join_date, o.order_id, o.order_date, o.order_total
from customers c, orders o 
where c.cust_id = o.cust_id and c.cust_id = 120;

select gender from customers;

select decode(c.gender, 'M', '����', '����') gender2, 
    case c.gender when 'M' then '����' else '����' end gender 3
from customers;

-- TODO : �� ID�� 110�� ���� �̸�, �ּ�, ��ȭ��ȣ, �װ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ֹ����� ��ȸ
-- result : 3
select c.cust_name, c.address, c.phone_number, o.order_id, o.order_date, o.order_status
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 110;
 

-- TODO : �� ID�� 120�� ���� ������ ���ݱ��� �ֹ��� �ֹ������� ��� ��ȸ.
-- result : 2

select * 
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;

select c.*, 
    o.order_date -- customers�� ��� �÷�, order���� order_date�� ����
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;

-- TODO : '2017/11/13'(�ֹ���¥) �� �ֹ��� �ֹ��� �ֹ����� ��_ID, �̸�, �ֹ�����, �ѱݾ��� ��ȸ
-- result : 2

select c.cust_id, c.cust_name, o.order_status, to_char(o.order_total,'fmL999,999') �ѱݾ� --fm : ������ֱ�, L : ����ȭ��
from orders o left join customers c on o.cust_id = c.cust_id
where o.order_date = to_date('2017/11/13','yyyy/mm/dd');

-- TODO : �ֹ��� ID�� xxxx(������ ID)�� �ֹ���ǰ�� ��ǰ�̸�, �ǸŰ���, ��ǰ������ ��ȸ.
-- result : check
select * from order_items;

select p.product_name, 
    oi.sell_price "�ǸŰ���", 
    p.price "��ǰ����",
    p.price - oi.sell_price "���ξ׼�"
from order_items oi left join products p on oi.product_id = p.product_id
where o.order_item_id = 1;
    
-- TODO : �ֹ� ID�� 4�� �ֹ��� �ֹ� ���� �̸�, �ּ�, �����ȣ, �ֹ���, �ֹ�����, �ѱݾ�, �ֹ� ��ǰ�̸�, ������, ��ǰ����, �ǸŰ���, ��ǰ������ ��ȸ.
-- result : 2

-- ����� Ǯ��
select c.cust_name, 
    c.address,
    c.postal_code,
    o.order_date, 
    o.order_status, 
    o.order_total, 
    p.product_name, 
    p.maker,
    p.price, 
    oi.sell_price, 
    oi.quantity
from orders o 
    left join customers c on o.cust_id = c.cust_id
    left join order_items oi on o.order_id = oi.order_id
    left join products p on oi.product_id = p.product_id 
where o.order_id = 4;

select c.cust_name, c.address,c.postal_code,o.order_date, o.order_status, o.order_total, p.product_name, p.price, i.sell_price, i.quantity
from order_items i
    inner join products p on i.product_id = p.product_id
    inner join orders o on i.order_id = o.order_id
    inner join customers c on o.cust_id = c.cust_id
where o.order_id = 4;


-- TODO : ��ǰ ID�� 200�� ��ǰ�� 2017�⿡ � �ֹ��Ǿ����� ��ȸ.
-- result : 4
-- check 

--����� Ǯ�� 
select * from products where product_id = 200;

select count(*) "�ֹ�Ƚ��", -- ��� �ֹ� �ƴ��� 
    sum(quantity) "���ֹ�����" -- ���� �ֹ��� ���� ���ؾ� �Ѵ�.
from products p 
    left join order_items oi on p.product_id = oi.product_id
    left join orders o on oi.order_id = o.order_id
where p.product_id = 200 and to_char(o.order_date,'yyyy') = '2017';


select count(*)
from order_items i
    inner join products p on i.product_id = p.product_id
    inner join orders o on i.order_id = o.order_id
where i.product_id = 200 and to_char(o.order_date,'yyyy') = to_char('2017');


-- TODO : ��ǰ�з��� �� �ֹ����� ��ȸ
-- reulst : 9

-- ����� Ǯ�� 
select distinct category from products;

select p.category, nvl(sum(quantity),0) "�ֹ�����"
from products p left join order_items oi on p.product_id = oi.product_id
group by p.category
order by 2;

-- �� Ǯ�� --> ���̽�ũ���� ������ �ȴ�. , count�� �ƴ϶� sum���� �Ǹ� ���� ���ϴ°� 
select i.product_id, count(*) "���ֹ���"
from order_items i inner join orders o on i.order_id = o.order_id
group by i.product_id;

