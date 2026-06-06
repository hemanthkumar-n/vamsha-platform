-- Correct the gendered Telugu grandchild calling terms.

update public.relationship_terms
set
  term = 'Manavadu',
  variants = array['Manavadu']::text[],
  updated_at = now()
where canonical_code = 'grandson_sons_son'
  and language_tag = 'te-IN'
  and source_type = 'workbook';

update public.relationship_terms
set
  term = 'Manavaralu',
  variants = array['Manavaralu']::text[],
  updated_at = now()
where canonical_code = 'granddaughter_sons_daughter'
  and language_tag = 'te-IN'
  and source_type = 'workbook';
