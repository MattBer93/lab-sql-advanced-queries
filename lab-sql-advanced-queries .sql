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
with cte_actor_multiple_movies as (
	select actor_id, count(film_id)
	from film_actor
	group by actor_id
	having count(film_id) > 1
) 
select fa.film_id, cte.actor_id from film_actor fa
join cte_actor_multiple_movies cte
on fa.actor_id = cte.actor_id;

