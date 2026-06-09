# Vamsha Development Guide

## Prerequisites

- Git
- Flutter with Dart 3 support
- Google Chrome for web development
- Optional Supabase project access

Check the local toolchain:

```bash
flutter --version
git --version
```

## Install Dependencies

From the repository root:

```bash
make get
```

Equivalent command:

```bash
cd mobile_app
flutter pub get
```

## Local Configuration

Copy the public template:

```bash
cp .env.example .env.local
```

Populate:

```json
{
  "SUPABASE_URL": "https://your-project.supabase.co",
  "SUPABASE_PUBLISHABLE_KEY": "sb_publishable_replace_me"
}
```

`.env.local` is ignored by Git.

Use only the Supabase publishable key in the Flutter application. Never place
a service-role key, database password, or secret token in this file when it
will be passed to a browser build.

## Run the Web App

Supabase-backed mode:

```bash
make run
```

Offline fallback mode:

```bash
cd mobile_app
flutter run -d chrome
```

The fallback mode loads `FounderGraph.localData`.

For a fixed local web-server port:

```bash
cd mobile_app
flutter run \
  -d web-server \
  --web-hostname 127.0.0.1 \
  --web-port 6015 \
  --dart-define-from-file=../.env.local
```

Open:

```text
http://127.0.0.1:6015/
```

## Quality Checks

Run before every commit:

```bash
make analyze
make test
git diff --check
git status
```

Current tests cover:

- Person language and location defaults
- Mother-tongue selection
- Relationship terminology
- Gender-correct Telugu terms
- Viewer-relative projections
- Family-specific calling overrides
- Sibling order
- Graph layout references
- Couple rendering
- Viewer camera focal points
- Repository JSON round trips
- Remote fallback behavior
- Runtime graph installation
- Responsive phone layout
- Responsive person profile panels
- Explicit profile-to-viewer switching

## Graph Data Workflow

The checked-in graph is defined in:

```text
mobile_app/lib/features/family/models/founder_graph.dart
```

Export it as JSON:

```bash
cd mobile_app
dart run tool/export_founder_graph.dart
```

Regenerate the Supabase graph migration:

```bash
cd mobile_app
dart run tool/generate_family_graph_migration.dart
```

After changing graph data:

1. Update or add projection tests.
2. Run the JSON round-trip test.
3. Regenerate the migration when remote seed data must change.
4. Review the generated SQL.
5. Apply through the approved Supabase migration workflow.
6. Verify the public read policy and browser result.

## Code Organization

```text
mobile_app/lib/features/family/
├── data/          # Repository and startup loading
├── domain/        # Projection and relationship terminology
├── models/        # Serializable graph entities
├── presentation/  # Screens and navigation
└── web/           # Family canvas layout and widgets
```

Keep responsibilities separate:

- Models contain data.
- Domain services calculate relationships.
- Repositories load data.
- Layout code positions graph nodes.
- Widgets render and handle interaction.

## Adding a Person

For the current prototype:

1. Add a `PersonEntity`.
2. Add required parent edges or family unit.
3. Add sibling order when elder/younger terminology matters.
4. Add language metadata only when it differs from graph defaults.
5. Add a viewer override only for a real family-specific exception.
6. Add tests from relevant viewer perspectives.
7. Regenerate the remote graph migration.

Do not encode viewer-relative words directly on `PersonEntity`.

## Adding Relationship Terms

Canonical relationships stay language-neutral. Language terms belong in the
relationship lexicon or generated term data.

When adding a term:

1. Identify the exact canonical relationship.
2. Record language and regional tag.
3. Confirm gender and elder/younger distinctions.
4. Add a focused term-service test.
5. Use an override only when the term is family-specific.

## Git Workflow

Recommended:

```bash
git status
git diff
make analyze
make test
git add <files>
git commit -m "type(scope): concise change"
git push
```

Do not commit:

- `.env.local`
- Build output
- Service-role credentials
- Private family files
- Unapproved personal photos or documents

## Definition of Done

A change is complete when:

- Behavior matches the viewer-centric model
- Responsive layout remains usable
- Tests cover the changed relationship path
- `flutter analyze` passes
- `flutter test` passes
- Browser verification shows no console errors
- Documentation is updated when architecture or behavior changes
