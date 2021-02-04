-- 업무별(job) 직원수를 조회, 직원수가 많은 것부터 정렬 
select job, count(*) from emp group by job order by 2 desc;

-- 부서명(dept_name) 업무(job) 별 직원수, 최고급여(salary)를 조회, 부서이름으로 오름차순 정렬 
--select dept_name, job, count(*) from group by dept_name, job order by 1;

-- emp테이블에서 입사연도별(hire_data) 총 급여(salary)의 합계을 조회. 
-- 급여 합계는 자리구분자, 를 넣으시도 

select to_char(hire_date,'yyyy') 입사년도,
    to_char(sum(salary),'fm9,999,999') 급여합계,
from emp 
group by to_char(hire_date, 'yyyy'); 

-- 업무와 입사년도 별 평균 급여을 조회
select job, extract(year from hire_date) "입사년도", 
    round(avg(salary),2) "평균급여"
from emp
group by job, extract(year from hire_date)
order by 1;

-- 부서별(dept_name) 직원수 조회하는 데 부서명(dept_name)이 null인것은 제외하고 조회.
select dept_name, count(*)
from emp
where dept_name is not null 
group by dept_name;

-- 급여 범위별 직원수를 출력, 급여 범위는 5000 미만, 5000이상 10000 미만, 10000이상 20000미만, 20000 이상 
select case when salary < 5000 then '1등급'
                when salary between 5000 and 9999.99 then '2등급' 
                when salary between 10000 and 19999.99 then '3등급' 
                else '4등급' end as '급여등급' ,
        count(*)
from emp
group by case when salary < 5000 then '1등급'
                when salary between 5000 and 9999.99 then '2등급' 
                when salary between 10000 and 19999.99 then '3등급' 
                else '4등급' end
order by 1 ; 










































