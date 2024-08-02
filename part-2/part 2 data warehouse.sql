create table if not exists events_row (
	device_id bigint,
	event_id bigserial,
	event_time timestamptz default now(),
	data jsonb not null
);

create table if not exists events_columnar (
	device_id bigint,
	event_id bigserial,
	event_time timestamptz default now(),
	data jsonb not null
)
USING columnar;

INSERT INTO events_columnar (device_id, data)
SELECT d, '{"hello": "columnar"}' FROM generate_series (1, 100) d;

INSERT INTO events_row (device_id, data)
SELECT d, '{"hello": "columnar"}' FROM generate_series (1, 100) d;