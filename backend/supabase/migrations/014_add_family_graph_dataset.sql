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
  $graph${"defaultLanguageProfile":{"uiLanguageTag":"en-IN","motherTongueTag":"te-IN","fluentLanguageTags":["te-IN"]},"people":[{"id":"narendranath","primaryName":"Natakam Narendranath","gender":"male"},{"id":"lakshmikanthamma","primaryName":"Natakam Lakshmikanthamma","gender":"female"},{"id":"mallikarjuna","primaryName":"Natakam Mallikarjuna Rao","gender":"male"},{"id":"akalhya","primaryName":"Natakam Akalhya","gender":"female"},{"id":"sandhya","primaryName":"Natakam Sandhya Rani","gender":"female"},{"id":"usha","primaryName":"Natakam Usha Rani","gender":"female"},{"id":"prasad","primaryName":"Natakam Malakonda Prasad","gender":"male","aliases":["N Malakonda Prasad","N M Prasad"],"knownAs":["Prasad"]},{"id":"subbarao","primaryName":"Mamidi Subbarao","gender":"male"},{"id":"samarajamma","primaryName":"Mamidi Samarajamma","gender":"female"},{"id":"suresh","primaryName":"Mamidi Suresh Kumar","gender":"male"},{"id":"ramesh","primaryName":"Mamidi Ramesh Babu","gender":"male"},{"id":"sudha","primaryName":"Natakam Sudha Rani","gender":"female","aliases":["Mamidi Sudha Rani"],"knownAs":["Sudha"]},{"id":"radha","primaryName":"Mamidi Radha Rani","gender":"female","aliases":["Dhampuri Radha Rani"]},{"id":"ganesh","primaryName":"Mamidi Ganesh Kumar","gender":"male"},{"id":"hemanth","primaryName":"Natakam Hemanth Kumar","gender":"male","siblingOrder":1,"languageProfile":{"uiLanguageTag":"en-IN","motherTongueTag":"te-IN","fluentLanguageTags":["te-IN","ta-IN","ml-IN","en-IN"]},"location":{"countryCode":"IN"}},{"id":"keerthi","primaryName":"Doguparthi Keerthi","gender":"female","aliases":["Keerthi Doguparti","Keerthi Doguparthi"],"knownAs":["Keerthi"]},{"id":"doguparthi_siva_prasad","primaryName":"Doguparthi Siva Prasad","gender":"male","knownAs":["Siva Prasad"]},{"id":"doguparthi_jayamma","primaryName":"Doguparthi Jayamma","gender":"female","knownAs":["Jayamma"]},{"id":"doguparthi_kiran","primaryName":"Doguparthi Kiran Kumar","gender":"male","knownAs":["Kiran"]},{"id":"divya","primaryName":"Natakam Divya Bharathi","gender":"female","siblingOrder":2},{"id":"kamesh","primaryName":"Buduri Kamesh","gender":"male"},{"id":"yuvan","primaryName":"Natakam Yuvan Simha","gender":"male"},{"id":"shreasta","primaryName":"Buduri Shreasta","gender":"female"},{"id":"vedhansh","primaryName":"Buduri Vedhansh","gender":"male"},{"id":"krithiksha","primaryName":"Buduri Krithiksha","gender":"female"}],"familyUnits":[{"id":"fu_natakam_root","partner1Id":"narendranath","partner2Id":"lakshmikanthamma"},{"id":"fu_mamidi_root","partner1Id":"subbarao","partner2Id":"samarajamma"},{"id":"fu_prasad_sudha","partner1Id":"prasad","partner2Id":"sudha"},{"id":"fu_hemanth_keerthi","partner1Id":"hemanth","partner2Id":"keerthi"},{"id":"fu_doguparthi_parents","partner1Id":"doguparthi_siva_prasad","partner2Id":"doguparthi_jayamma"},{"id":"fu_divya_kamesh","partner1Id":"divya","partner2Id":"kamesh"}],"relationships":[{"sourceId":"narendranath","targetId":"mallikarjuna","type":"parent"},{"sourceId":"lakshmikanthamma","targetId":"mallikarjuna","type":"parent"},{"sourceId":"narendranath","targetId":"akalhya","type":"parent"},{"sourceId":"lakshmikanthamma","targetId":"akalhya","type":"parent"},{"sourceId":"narendranath","targetId":"sandhya","type":"parent"},{"sourceId":"lakshmikanthamma","targetId":"sandhya","type":"parent"},{"sourceId":"narendranath","targetId":"usha","type":"parent"},{"sourceId":"lakshmikanthamma","targetId":"usha","type":"parent"},{"sourceId":"narendranath","targetId":"prasad","type":"parent"},{"sourceId":"lakshmikanthamma","targetId":"prasad","type":"parent"},{"sourceId":"subbarao","targetId":"suresh","type":"parent"},{"sourceId":"samarajamma","targetId":"suresh","type":"parent"},{"sourceId":"subbarao","targetId":"ramesh","type":"parent"},{"sourceId":"samarajamma","targetId":"ramesh","type":"parent"},{"sourceId":"subbarao","targetId":"sudha","type":"parent"},{"sourceId":"samarajamma","targetId":"sudha","type":"parent"},{"sourceId":"subbarao","targetId":"radha","type":"parent"},{"sourceId":"samarajamma","targetId":"radha","type":"parent"},{"sourceId":"subbarao","targetId":"ganesh","type":"parent"},{"sourceId":"samarajamma","targetId":"ganesh","type":"parent"},{"sourceId":"prasad","targetId":"hemanth","type":"parent"},{"sourceId":"sudha","targetId":"hemanth","type":"parent"},{"sourceId":"prasad","targetId":"divya","type":"parent"},{"sourceId":"sudha","targetId":"divya","type":"parent"},{"sourceId":"hemanth","targetId":"yuvan","type":"parent"},{"sourceId":"keerthi","targetId":"yuvan","type":"parent"},{"sourceId":"doguparthi_siva_prasad","targetId":"keerthi","type":"parent"},{"sourceId":"doguparthi_jayamma","targetId":"keerthi","type":"parent"},{"sourceId":"doguparthi_siva_prasad","targetId":"doguparthi_kiran","type":"parent"},{"sourceId":"doguparthi_jayamma","targetId":"doguparthi_kiran","type":"parent"},{"sourceId":"divya","targetId":"shreasta","type":"parent"},{"sourceId":"kamesh","targetId":"shreasta","type":"parent"},{"sourceId":"divya","targetId":"vedhansh","type":"parent"},{"sourceId":"kamesh","targetId":"vedhansh","type":"parent"},{"sourceId":"divya","targetId":"krithiksha","type":"parent"},{"sourceId":"kamesh","targetId":"krithiksha","type":"parent"}],"viewerRelationshipOverrides":[{"viewerId":"hemanth","targetId":"mallikarjuna","canonicalRelationship":"paternal_uncle_fathers_elder_brother","relationship":"Paternal Uncle","culturalRelationship":"Pedhananna"},{"viewerId":"hemanth","targetId":"akalhya","canonicalRelationship":"paternal_aunt_fathers_sister","relationship":"Paternal Aunt","culturalRelationship":"Pedha Attha"},{"viewerId":"hemanth","targetId":"usha","canonicalRelationship":"paternal_aunt_fathers_sister","relationship":"Paternal Aunt","culturalRelationship":"Attha"},{"viewerId":"hemanth","targetId":"radha","canonicalRelationship":"maternal_aunt_mothers_younger_sister","relationship":"Maternal Aunt","culturalRelationship":"Pinni"},{"viewerId":"hemanth","targetId":"divya","canonicalRelationship":"younger_sister","relationship":"Sister","culturalRelationship":"Chelli"},{"viewerId":"hemanth","targetId":"kamesh","canonicalRelationship":"brother_in_law_sisters_husband","relationship":"Brother-in-law","culturalRelationship":"Bava"},{"viewerId":"hemanth","targetId":"shreasta","canonicalRelationship":"niece","relationship":"Niece","culturalRelationship":"Kodalu"},{"viewerId":"hemanth","targetId":"vedhansh","canonicalRelationship":"nephew","relationship":"Nephew","culturalRelationship":"Alludu"},{"viewerId":"hemanth","targetId":"krithiksha","canonicalRelationship":"niece","relationship":"Niece","culturalRelationship":"Kodalu"},{"viewerId":"doguparthi_jayamma","targetId":"divya","canonicalRelationship":"daughter_in_law","relationship":"Daughter-in-law","culturalRelationship":"Kodalu"},{"viewerId":"doguparthi_jayamma","targetId":"kamesh","canonicalRelationship":"son","relationship":"Son","culturalRelationship":"Koduku"},{"viewerId":"doguparthi_jayamma","targetId":"shreasta","canonicalRelationship":"granddaughter","relationship":"Granddaughter","culturalRelationship":"Kodalu"},{"viewerId":"doguparthi_jayamma","targetId":"vedhansh","canonicalRelationship":"grandson","relationship":"Grandson","culturalRelationship":"Alludu"},{"viewerId":"doguparthi_jayamma","targetId":"krithiksha","canonicalRelationship":"granddaughter","relationship":"Granddaughter","culturalRelationship":"Kodalu"}]}$graph$::jsonb,
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
