# Local profile storage

Vamsha's founder graph still supplies people, parent links, marriages,
relationship overrides, and layout. Each person has a stable `PersonEntity.id`.
The editor stores personal details separately under that ID, so a newer founder
graph can load without discarding locally edited details.

## Current storage

`LocalProfileStore` has two records keyed by the same person ID:

- `person_profiles`: full name, known-as names, aliases, native place, religion.
- `profile_photos`: content type, photo bytes, and a stable asset key.

Web uses Sembast on IndexedDB. Android, iOS, and desktop use a Sembast file in
the application's documents directory. Profile edits are applied over the
loaded graph at startup and after a save. The photo is kept separate from the
graph JSON and shown in the person's profile. Saves of details and a new photo
use one local database transaction.

The photo key is `founder_family/{personId}/profile`. When Vamsha supports more
families, each family must have a globally unique family ID and new people
should receive generated immutable IDs. Cloud objects can then use a path such
as `{familyId}/{personId}/profile/{version}.jpg`, while the profile record
holds the current object key. A cloud migration should copy the image bytes,
verify the upload, then replace the local asset reference. Public URLs should
not be treated as identity or stored as the only photo reference.

## Boundaries

Current editing covers existing people's details and one profile photo per
person. It does not yet create people or change parent/spouse links. Graph
edits need validation, permissions, and a write repository before moving to
shared storage. Supabase remains a read source for the founder graph; local
profile edits are private to this browser profile or device and are not synced
between devices. Browser storage is scoped to the site origin, including port,
and may be removed if browser data is cleared. Use a fixed local preview URL
when testing persistence.

Before cloud sync, add authentication and family-scoped permissions, a person
write model, photo access policies, and a migration path for existing local
records. Keeping the graph, personal details, and photo references separate
allows those pieces to move independently.
