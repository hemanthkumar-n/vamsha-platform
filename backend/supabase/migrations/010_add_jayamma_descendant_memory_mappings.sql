-- Preserve Jayamma's calling names for Kamesh and Divya's children.

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
    'doguparthi_jayamma',
    'shreasta',
    'granddaughter',
    'Granddaughter',
    'Kodalu',
    'te-IN',
    true,
    'founder_family_memory'
  ),
  (
    'doguparthi_jayamma',
    'vedhansh',
    'grandson',
    'Grandson',
    'Alludu',
    'te-IN',
    true,
    'founder_family_memory'
  ),
  (
    'doguparthi_jayamma',
    'krithiksha',
    'granddaughter',
    'Granddaughter',
    'Kodalu',
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
