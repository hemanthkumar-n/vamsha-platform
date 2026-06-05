# Relationship Language Excel Format

## Purpose

Use this workbook format to import cultural relationship terms without
changing the canonical family graph.

One row represents one term in one language.

## Required Columns

| Column | Example | Meaning |
| --- | --- | --- |
| `canonical_relationship` | `father` | Stable Vamsha relationship code |
| `language_tag` | `te-IN` | BCP-47 language tag |
| `display_term` | `Nanna` | Term shown to the viewer |

## Recommended Columns

| Column | Example | Meaning |
| --- | --- | --- |
| `native_script_term` | `నాన్న` | Optional term in its native script |
| `country_code` | `IN` | ISO two-letter country code |
| `state_or_region` | `Andhra Pradesh` | Region where the term is common |
| `usage_scope` | `regional` | `global`, `country`, `regional`, or `family` |
| `formality` | `informal` | `formal`, `informal`, or `neutral` |
| `gender_context` | `male` | Gender context when relevant |
| `age_context` | `any` | `elder`, `younger`, or `any` |
| `family_variant` |  | Family-preferred alternative |
| `notes` | `Common Telugu usage` | Import notes |

## Example Rows

| canonical_relationship | language_tag | display_term | country_code | state_or_region | usage_scope |
| --- | --- | --- | --- | --- | --- |
| father | te-IN | Nanna | IN | Andhra Pradesh | regional |
| father | ta-IN | Appa | IN | Tamil Nadu | regional |
| father | ml-IN | Achan | IN | Kerala | regional |

## Profile Fields

Every individual profile stores:

- `ui_language_tag`: language used by the application
- `mother_tongue_tag`: the person's native language and default kinship language
- `fluent_language_tags`: other languages the person understands or speaks
- `country_code`: ISO two-letter country code
- `administrative_area`: state or region
- `locality`: city, town, or village
- `native_place`: family or ancestral place
- `religion`: optional self-described religion

Use `und` when the mother tongue is not yet known. Do not infer a person's
mother tongue only from their surname or current location.

Fluent languages do not override the mother tongue when selecting calling
terms. They are available for explicit language previews and future UI
language choices.
