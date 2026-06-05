-- Normalize language and location preferences for every human profile.
-- Language values use BCP-47 tags (for example te-IN, ta-IN, en-IN).
-- Country values use ISO 3166-1 alpha-2 codes (for example IN, US).

alter table human_entities
  add column if not exists ui_language_tag text not null default 'en',
  add column if not exists mother_tongue_tag text not null default 'und',
  add column if not exists fluent_language_tags text[] not null
    default array[]::text[],
  add column if not exists country_code text,
  add column if not exists administrative_area text,
  add column if not exists locality text,
  add column if not exists religion text;

alter table human_entities
  add constraint human_entities_country_code_format
  check (country_code is null or country_code ~ '^[A-Z]{2}$');

comment on column human_entities.ui_language_tag is
  'Preferred application language as a BCP-47 tag.';
comment on column human_entities.mother_tongue_tag is
  'Primary native language as a BCP-47 tag; und means unspecified.';
comment on column human_entities.fluent_language_tags is
  'Languages understood or spoken by the person as BCP-47 tags.';
comment on column human_entities.country_code is
  'ISO 3166-1 alpha-2 country code.';
comment on column human_entities.administrative_area is
  'State, province, or comparable first-level region.';
comment on column human_entities.locality is
  'City, town, village, or comparable locality.';
comment on column human_entities.religion is
  'Optional self-described religion; never inferred from name or location.';
