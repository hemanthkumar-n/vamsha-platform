# Vamsha Backend Foundation

Supabase provides the PostgreSQL, Row Level Security, and future authentication
foundation for Vamsha.

The Flutter app loads the active `founder_family` graph from
`family_graph_datasets` when `SUPABASE_URL` and
`SUPABASE_PUBLISHABLE_KEY` are supplied as Dart defines.

Local development:

```bash
cp .env.example .env.local
./scripts/run-web.sh
```

The checked-in founder graph remains an offline fallback. The public client
has read-only access to the active founder dataset through Row Level Security;
writes remain restricted to the service role.

## Migration Areas

The migration history includes foundations for:

- Human entities and relationship edges
- Spaces and memberships
- Language and cultural relationship terms
- Viewer-specific relationship overrides
- Identity claims, invitations, and governance
- Versioned graph datasets

The currently integrated production path is the read-only
`family_graph_datasets` projection. Normalized editing and family-scoped
authentication are the next milestone.

## Security

- The browser uses only a publishable key.
- Service-role credentials stay in trusted backend or migration environments.
- `.env.local` is ignored by Git.
- Public access is currently limited to the active founder prototype dataset.
- User-created family graphs must use authenticated, family-scoped RLS before
  launch.

See [Architecture](../../docs/ARCHITECTURE.md),
[Data Model](../../docs/DATA_MODEL.md), and
[Development Guide](../../docs/DEVELOPMENT.md).
