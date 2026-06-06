-- Use the culturally specific Telugu calling term for a son-in-law.

update public.relationship_terms
set
  term = 'Alludu',
  variants = array['Alludu', 'Abbayi']::text[],
  updated_at = now()
where canonical_code = 'son_in_law'
  and language_tag = 'te-IN'
  and source_type = 'workbook';
