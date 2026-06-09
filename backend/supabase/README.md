# Vamsha Backend Foundation

Supabase backend foundation.

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
