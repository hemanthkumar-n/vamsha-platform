# Vamsha Data Model

## Modeling Principle

A person is an entity. A relationship label is a viewer-relative projection.

Vamsha therefore stores canonical facts such as parenthood and partnership,
then calculates labels such as mother, aunt, brother-in-law, or grandmother
for a selected viewer.

## Runtime Graph

`FamilyGraphData` is the serializable root object used by Flutter.

```text
FamilyGraphData
├── people
├── familyUnits
├── relationships
└── viewerRelationshipOverrides
```

### PersonEntity

Represents a human independently of login or platform ownership.

Current fields:

| Field | Purpose |
| --- | --- |
| `id` | Stable graph identifier |
| `primaryName` | Main display name |
| `gender` | Relationship and term inference |
| `siblingOrder` | Elder/younger sibling inference |
| `aliases` | Alternate or post-marriage names |
| `knownAs` | Familiar names used by family |
| `languageProfile` | UI, mother tongue, and fluent languages |
| `location` | Country, region, locality, and native place |
| `culturalProfile` | Optional cultural metadata |

`PersonEntity` is not an authenticated account. A future account may claim or
manage a person profile through a governed identity workflow.

### PersonLanguageProfile

Fields:

- `uiLanguageTag`
- `motherTongueTag`
- `fluentLanguageTags`

Relationship term selection uses:

1. Mother tongue when specified
2. First fluent language when mother tongue is unknown
3. UI language as the fallback

Language tags use BCP 47-style values such as:

- `en-IN`
- `te-IN`
- `ta-IN`
- `ml-IN`

### PersonLocation

Optional fields:

- `countryCode`
- `administrativeArea`
- `locality`
- `nativePlace`

Location supports identity distinction and future search or community
grouping. It must not automatically become public profile data.

### PersonCulturalProfile

The current optional field is `religion`.

This is sensitive metadata. Future persistence and display must be opt-in,
permission-controlled, and unnecessary for basic relationship projection.

### FamilyUnit

A family unit groups two partners:

```text
FamilyUnit
├── id
├── partner1Id
└── partner2Id
```

The unit supports couple rendering without merging two people into one
record.

### RelationshipEdge

Stores canonical directed graph facts:

```text
source person -> relationship type -> target person
```

The current founder graph primarily stores `parent` edges. Partnership is
represented by `FamilyUnit`.

The graph does not store labels like "uncle" or "granddaughter" because those
depend on the viewer.

### ViewerRelationshipOverride

Some family calling conventions cannot be safely inferred from a generic
language dictionary.

An override includes:

| Field | Meaning |
| --- | --- |
| `viewerId` | Person doing the viewing or calling |
| `targetId` | Person being described |
| `canonicalRelationship` | Precise relationship code |
| `relationship` | English display |
| `culturalRelationship` | Family-preferred calling name |

Overrides are scoped to viewer and target. They do not rename the target
globally.

## Relationship Projection

The projection engine evaluates direct and graph-derived paths:

- Self
- Parent and child
- Spouse
- Sibling, including elder/younger order
- Grandparent and grandchild
- Parent's sibling
- Sibling's child
- In-law paths
- Family-specific overrides

Projection output:

```text
RelationshipProjection
├── viewerId
├── targetId
├── canonicalRelationship
├── relationship
└── culturalRelationship
```

## Supabase Read Model

The active application read model is:

```sql
public.family_graph_datasets
```

| Column | Purpose |
| --- | --- |
| `dataset_key` | Stable projection name |
| `schema_version` | Serialized format version |
| `graph_data` | JSONB `FamilyGraphData` |
| `is_active` | Publish switch |
| `published_at` | Publication timestamp |
| `updated_at` | Last update timestamp |

The public client can read only the active founder dataset. It cannot insert,
update, or delete rows.

## Normalized Future Write Model

The migration set also establishes foundations for:

- Human entities
- Relationship edges
- Spaces and memberships
- Relationship terms
- Viewer relationship context
- Identity claims
- Access policies
- Invitations
- Change requests
- Audit logs
- Memories

These tables represent the intended editable and governed model. They should
not be described as fully integrated until the Flutter write flows and
family-scoped RLS policies are implemented.

## Validation Rules

Current and future graph validation should enforce:

1. Every relationship endpoint references an existing person.
2. Every family-unit partner references an existing person.
3. A person cannot be their own parent or partner.
4. Parent cycles are invalid.
5. Sibling order is optional but must be positive when present.
6. Viewer overrides require valid viewer and target IDs.
7. Canonical relationship codes remain language-neutral.
8. Sensitive cultural and location fields default to private.

## Privacy Classification

Suggested classification:

| Data | Default treatment |
| --- | --- |
| Primary name | Family-visible |
| Relationship edges | Family-visible |
| Aliases and known-as names | Family-visible |
| Mother tongue | Profile-controlled |
| Location | Private or profile-controlled |
| Religion | Private and optional |
| Contact identity | Private |
| Memories and documents | Explicit audience |

The current public founder dataset is prototype data. User-created datasets
must use authenticated, family-scoped policies.
