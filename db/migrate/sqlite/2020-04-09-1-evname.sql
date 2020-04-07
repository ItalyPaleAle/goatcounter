begin;
	create table hits2 (
		id             integer        primary key autoincrement,
		site           integer        not null                 check(site > 0),
		session        integer        default null,
		started_session integer        default 0,

		path           varchar        not null,
		title          varchar        not null default '',
		event          varchar        null,
		bot            int            default 0,
		ref            varchar        not null,
		ref_original   varchar,
		ref_params     varchar,
		ref_scheme     varchar        null                     check(ref_scheme in ('h', 'g', 'o')),
		browser        varchar        not null,
		size           varchar        not null default '',
		location       varchar        not null default '',

		created_at     timestamp      not null                 check(created_at = strftime('%Y-%m-%d %H:%M:%S', created_at))
	);

	insert into hits2 select * from hits;
	drop table hits;
	alter table hits2 rename to hits;

	update hits set event=path, path='/' where event='1';
	update hits set event=null where event='0';

	insert into version values ('2020-04-09-1-evname');
commit;
