-- Sibling order allows viewer-relative elder/younger relationship terms.

alter table public.human_entities
  add column if not exists sibling_order integer;

alter table public.human_entities
  add constraint human_entities_sibling_order_positive
  check (sibling_order is null or sibling_order > 0);

comment on column public.human_entities.sibling_order is
  'Relative birth order among siblings sharing the same parents; 1 is eldest.';

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
  'divya',
  'hemanth',
  'elder_brother',
  'Elder Brother',
  'Anna',
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
