begin;
	create index "hits#event" on hits(event);  -- Will take ages otherwise; removed on drop column.

	alter table hits
		add column event2 varchar default null;

	update hits set event2=path, path='/' where event='1';

	alter table hits drop column event;
	alter table hits rename event2 to event;

	create index "hits#site#bot#event#created_at" on hits(site, bot, event, created_at);
	drop index "hits#site#bot#created_at";

	insert into version values ('2020-04-09-1-evname');
commit;

