import 'dart:convert';
import 'dart:io';

import 'package:vansha_mobile/features/family/models/founder_graph.dart';

Future<void> main(List<String> args) async {
  final outputPath = args.isEmpty
      ? '../backend/supabase/migrations/014_add_family_graph_dataset.sql'
      : args.first;
  final graphJson = jsonEncode(FounderGraph.localData.toJson());
  final sql = '''
-- Versioned, atomic family graph dataset consumed by Flutter at startup.

create table if not exists public.family_graph_datasets (
  dataset_key text primary key,
  schema_version integer not null default 1,
  graph_data jsonb not null,
  is_active boolean not null default true,
  published_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.family_graph_datasets enable row level security;

drop policy if exists "Founder graph is publicly readable"
  on public.family_graph_datasets;

create policy "Founder graph is publicly readable"
  on public.family_graph_datasets
  for select
  to anon, authenticated
  using (dataset_key = 'founder_family' and is_active);

revoke all on table public.family_graph_datasets from anon, authenticated;
grant select on table public.family_graph_datasets to anon, authenticated;
grant select, insert, update, delete
  on table public.family_graph_datasets
  to service_role;

insert into public.family_graph_datasets (
  dataset_key,
  schema_version,
  graph_data,
  is_active,
  published_at,
  updated_at
)
values (
  'founder_family',
  1,
  \$graph\$$graphJson\$graph\$::jsonb,
  true,
  now(),
  now()
)
on conflict (dataset_key)
do update set
  schema_version = excluded.schema_version,
  graph_data = excluded.graph_data,
  is_active = excluded.is_active,
  published_at = excluded.published_at,
  updated_at = excluded.updated_at;
''';

  await File(outputPath).writeAsString(sql);
}
