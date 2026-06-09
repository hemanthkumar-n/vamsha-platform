# Vamsha Flutter App

The Flutter application renders Vamsha's viewer-centric family web for web and
future Android/iOS releases.

## Responsibilities

- Load the active family graph from Supabase
- Fall back to the checked-in founder graph
- Project relationships from the selected viewer
- Select cultural calling names from language and family context
- Render the responsive, zoomable family canvas

## Run

From the repository root:

```bash
cp .env.example .env.local
make get
make run
```

For offline fallback:

```bash
flutter run -d chrome
```

## Verify

```bash
flutter analyze
flutter test
```

See the repository [README](../README.md) and
[Development Guide](../docs/DEVELOPMENT.md) for full setup and architecture.
