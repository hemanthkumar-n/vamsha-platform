-- Preserve Hemanth's calling names for his father's elder siblings.

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
values
  (
    'hemanth',
    'mallikarjuna',
    'paternal_uncle_fathers_elder_brother',
    'Paternal Uncle',
    'Pedhananna',
    'te-IN',
    true,
    'founder_family_memory'
  ),
  (
    'hemanth',
    'akalhya',
    'paternal_aunt_fathers_sister',
    'Paternal Aunt',
    'Pedha Attha',
    'te-IN',
    true,
    'founder_family_memory'
  ),
  (
    'hemanth',
    'usha',
    'paternal_aunt_fathers_sister',
    'Paternal Aunt',
    'Attha',
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
