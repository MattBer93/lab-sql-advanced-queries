use sakila;

-- List each pair of actors that have worked together.

select fa1.actor_id, fa2.actor_id, fa1.film_id from film_actor fa1
join film_actor fa2
on fa1.film_id = fa2.film_id
and fa1.actor_id <> fa2.actor_id;

-- For each film, list actor that has acted in more films.
-- 1. Find actors that have acted in more films
select actor_id, count(film_id)
from film_actor
group by actor_id
having count(film_id) > 1;

-- 2. Create a CTE with the code above
with cte as (
	select actor_id, count(film_id) as total_movies
    from film_actor
    group by actor_id
    order by actor_id
),
cte2 as (
	select film_id, actor_id, total_movies,
    row_number() over (partition by film_id order by total_movies desc) as flag
    from cte
    join film_actor using (actor_id)
    order by film_id asc, total_movies desc
)
select film_id, actor_id from cte2
where flag = 1;

