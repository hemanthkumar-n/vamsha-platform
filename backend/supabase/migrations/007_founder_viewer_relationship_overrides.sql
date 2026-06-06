-- Founder-family calling conventions that differ from strict graph labels.

alter table public.viewer_relationship_context
  add column if not exists viewer_reference_key text,
  add column if not exists target_reference_key text,
  add column if not exists relationship_label text,
  add column if not exists source_type text not null default 'user_defined',
  add column if not exists updated_at timestamptz not null default now();

create unique index if not exists viewer_relationship_context_reference_uidx
  on public.viewer_relationship_context (
    viewer_reference_key,
    target_reference_key
  )
  where viewer_reference_key is not null
    and target_reference_key is not null;

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
    'kamesh',
    'brother_in_law_sisters_husband',
    'Brother-in-law',
    'Bava',
    'te-IN',
    true,
    'founder_family'
  ),
  (
    'doguparthi_jayamma',
    'divya',
    'daughter',
    'Daughter',
    'Kuthuru',
    'te-IN',
    true,
    'founder_family'
  ),
  (
    'doguparthi_jayamma',
    'kamesh',
    'son_in_law',
    'Son-in-law',
    'Alludu',
    'te-IN',
    true,
    'founder_family'
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

alter table public.viewer_relationship_context enable row level security;

revoke all on table public.viewer_relationship_context
  from anon, authenticated;
grant select, insert, update, delete
  on table public.viewer_relationship_context
  to service_role;
