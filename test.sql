select t.status as 'Статус', 
substr(t.issue_key, 1, 1) as 'Группа задачи',
round(avg((t.st*1.0)/60), 2) as 'Среднее время в работе'
from(
	select h.status, h.issue_key, sum(h.minutes_in_status) st
	from history h
	where status = 'Open'
	group by h.issue_key) t 
group by 2

select h.issue_key as 'Ключ задачи', h.status as 'Последний статус', datetime(round(h.started_at/1000), 'unixepoch', 'localtime') as 'Время создания'
from history h 
where status != 'Closed'
AND 
status != 'Resolved'
group by 1
having max(started_at)
