-- Store alternate profile names and Hemanth's calling memory for Radha.

alter table public.human_entities
  add column if not exists aliases text[] not null default array[]::text[];

comment on column public.human_entities.aliases is
  'Alternate, former, married, or family-known names for the person.';

insert into public.viewer_relationship_context (
  viewer_reference_key,
  target_reference_key,
  canonical_relationship,
  relationship_label,
  display_term,
  language,
  custom_defined,
  source_type
)
values (
  'hemanth',
  'radha',
  'maternal_aunt_mothers_younger_sister',
  'Maternal Aunt',
  'Pinni',
  'te-IN',
  true,
  'founder_family_memory'
)
on conflict (viewer_reference_key, target_reference_key)
  where viewer_reference_key is not null
    and target_reference_key is not null
do update set
  canonical_relationship = excluded.canonical_relationship,
  relationship_label = excluded.relationship_label,
  display_term = excluded.display_term,
  language = excluded.language,
  custom_defined = excluded.custom_defined,
  source_type = excluded.source_type,
  updated_at = now();
