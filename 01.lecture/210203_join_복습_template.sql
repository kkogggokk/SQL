/*
1. 제품 테이블은 제품_ID 컬럼이 [Primary key] 컬럼으로 그 행을 다른 행과 식별할 때 사용된다.
2. 제품 테이블의 제조사 컬럼은 Not Null(NN) 인 것으로 봐서 [null] 인 상태일 수가 없다.
3. 고객 테이블에서 다른행과 식별할 때 사용하는 컬럼은 [고객_ID(cust_id)] 이다. 
4. 고객 테이블의 전화번호 컬럼의 데이터 타입은 [vachar2] 으로 [문자열]형태의 값 [15]바이트 저장할 수 있으며 NULL 값을 [허용한다].
5. 고객 테이블의 가입일 컬럼에 대해 4번 처럼 설명해 보시오.
    [DATE 타입으로 날짜와 시간을 저장]
6. 주문 테이블은 총 5개 컬럼이 있다. 정수 타입이 [3]개이고 문자열 타입이 [1]개 이고 날짜 타입이 [1]개이다.
7. 고객 테이블과 주문테이블은 서로 관계가 있는 테이블입니다.
    부모테이블은 [고객(customers] 이고 자식 테이블은 [주문(orders)]이다.
    부모테이블의 [고객_id(cust_id),PK]컬럼을 자식테이블의 [고객_id(cust_id_,FK]컬럼이 참조하고 있다.
    고객테이블의 한행의 데이터는 주문테이블의 [0~N] 행과 관계가 있을 수 있다.
    주문테이블의 한행은 고객테이블의 [1] 행과 관계가 있을 수 있다.
8. 주문 테이블과 주문_제품 테이블은 서로 관계가 있는 테이블입니다.
    부모 테이블은 [주문(orders)] 이고 자식 테이블은 [주문_제품(order_items)]이다.
    부모 테이블의 _______________컬럼을 자식 테이블의 ___________________컬럼이 참조하고 있다.
    주문 테이블의 한행의 데이터는 주문_제품 테이블의 [0~N] 행과 관계가 있을 수 있다.
    주문_제품 테이블의 한행은 주문 테이블의 [1]행과 관계가 있을 수 있다.
9. 제품과 주문_제품은 서로 관계가 있는 테이블입니다. 
    부모 테이블은 ___________________ 이고 자식 테이블은 ________________이다.
    부모 테이블의 _______________컬럼을 자식 테이블의 ___________________컬럼이 참조하고 있다.
    제품 테이블의 한행의 데이터는 주문_제품 테이블의 _________________ 행과 관계가 있을 수 있다.
    주문_제품 테이블의 한행은 제품 테이블의 __________________행과 관계가 있을 수 있다.
*/

-- TODO: 4개의 테이블에 어떤 값들이 있는지 확인.

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

-- TODO: 주문 번호가 1인 주문의 주문자 이름, 주소, 우편번호, 전화번호 조회
-- result : 1

select c.cust_name, c.address, c.postal_code, c.phone_number 
from customers c inner join orders o on c.cust_id = o.cust_id
where o.order_id = 1 ;

-- TODO : 주문 번호가 2인 주문의 주문일, 주문상태, 총금액, 주문고객 이름, 주문고객 이메일 주소 조회
-- result : 1

select o.order_date,o.order_status, o.order_total, c.cust_name, c.cust_email
from customers c inner join orders o on c.cust_id = o.cust_id
where order_id = 2;

-- TODO : 고객 ID가 120인 고객의 이름, 성별, 가입일과 지금까지 주문한 주문정보중 주문_ID, 주문일, 총금액을 조회
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

select decode(c.gender, 'M', '남성', '여성') gender2, 
    case c.gender when 'M' then '남성' else '여성' end gender 3
from customers;

-- TODO : 고객 ID가 110인 고객의 이름, 주소, 전화번호, 그가 지금까지 주문한 주문정보중 주문_ID, 주문일, 주문상태 조회
-- result : 3
select c.cust_name, c.address, c.phone_number, o.order_id, o.order_date, o.order_status
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 110;
 

-- TODO : 고객 ID가 120인 고객의 정보와 지금까지 주문한 주문정보를 모두 조회.
-- result : 2

select * 
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;

select c.*, 
    o.order_date -- customers의 모든 컬럼, order에서 order_date만 선택
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;

-- TODO : '2017/11/13'(주문날짜) 에 주문된 주문의 주문고객의 고객_ID, 이름, 주문상태, 총금액을 조회
-- result : 2

select c.cust_id, c.cust_name, o.order_status, to_char(o.order_total,'fmL999,999') 총금액 --fm : 공백없애기, L : 현지화폐
from orders o left join customers c on o.cust_id = c.cust_id
where o.order_date = to_date('2017/11/13','yyyy/mm/dd');

-- TODO : 주문상세 ID가 xxxx(임의의 ID)인 주문제품의 제품이름, 판매가격, 제품가격을 조회.
-- result : check
select * from order_items;

select p.product_name, 
    oi.sell_price "판매가격", 
    p.price "제품가격",
    p.price - oi.sell_price "할인액수"
from order_items oi left join products p on oi.product_id = p.product_id
where o.order_item_id = 1;
    
-- TODO : 주문 ID가 4인 주문의 주문 고객의 이름, 주소, 우편번호, 주문일, 주문상태, 총금액, 주문 제품이름, 제조사, 제품가격, 판매가격, 제품수량을 조회.
-- result : 2

-- 강사님 풀이
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


-- TODO : 제품 ID가 200인 제품이 2017년에 몇개 주문되었는지 조회.
-- result : 4
-- check 

--강사님 풀이 
select * from products where product_id = 200;

select count(*) "주문횟수", -- 몇번 주문 됐는지 
    sum(quantity) "총주문갯수" -- 갯수 주문의 합을 구해야 한다.
from products p 
    left join order_items oi on p.product_id = oi.product_id
    left join orders o on oi.order_id = o.order_id
where p.product_id = 200 and to_char(o.order_date,'yyyy') = '2017';


select count(*)
from order_items i
    inner join products p on i.product_id = p.product_id
    inner join orders o on i.order_id = o.order_id
where i.product_id = 200 and to_char(o.order_date,'yyyy') = to_char('2017');


-- TODO : 제품분류별 총 주문량을 조회
-- reulst : 9

-- 강사님 풀이 
select distinct category from products;

select p.category, nvl(sum(quantity),0) "주문수량"
from products p left join order_items oi on p.product_id = oi.product_id
group by p.category
order by 2;

-- 내 풀이 --> 아이스크림이 빠지게 된다. , count가 아니라 sum으로 판매 갯수 구하는거 
select i.product_id, count(*) "총주문량"
from order_items i inner join orders o on i.order_id = o.order_id
group by i.product_id;

