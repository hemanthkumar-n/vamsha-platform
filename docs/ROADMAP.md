# Vamsha Product Roadmap

## Guiding Sequence

Vamsha should become trustworthy before it becomes social.

The recommended order is:

```text
Relationship correctness
-> Editable graph
-> Identity and privacy
-> Collaboration
-> Memories and social features
-> AI assistance
```

## Milestone 1: Viewer-Centric Founder Web

Status: **Completed**

- Zoomable family canvas
- Viewer switching
- Responsive viewer focus
- Couple and family-unit rendering
- Paternal, maternal, in-law, sibling, and descendant branches
- Relationship connector layer

## Milestone 2: Relationship Intelligence

Status: **Completed for the founder dataset**

- Canonical graph-based relationship projection
- Viewer-relative labels
- Elder and younger sibling inference
- English and Telugu calling display
- Mother-tongue preference
- Family-specific calling overrides
- Alias and known-as support
- Automated projection and terminology tests

## Milestone 3: Supabase Read Integration

Status: **Completed**

- Serializable `FamilyGraphData`
- Repository abstraction
- Supabase graph repository
- Local fallback repository
- Runtime graph installation
- Versioned founder dataset
- Public read-only RLS policy
- Local environment configuration

## Milestone 4: Editable Family Graph

Status: **In progress**

- Read-only responsive person profile panel completed
- Immediate family, language, alias, and location display completed
- Explicit profile-to-viewer switching completed
- Authenticated development user
- Person profile create and edit
- Parent, child, spouse, and sibling editing
- Form validation
- Graph cycle prevention
- Optimistic UI with error recovery
- Family-scoped write permissions
- Audit record for relationship changes
- Publish normalized edits into a graph projection

Exit criteria:

- A permitted user can add or edit a person without changing Dart source.
- The family web refreshes from persisted data.
- Unauthorized writes are rejected by RLS.

## Milestone 5: Identity, Invitations, and Governance

Status: **Planned**

- User account separate from person entity
- Profile claim workflow
- Invite links and expiration
- Family roles
- Change requests and approvals
- Duplicate detection and merge review
- Audit history

## Milestone 6: Private Family Spaces

Status: **Planned**

- Multiple family graphs
- Family-scoped memberships
- Branch-level visibility
- Profile privacy controls
- Private search
- Safe handling of location and cultural metadata

## Milestone 7: Memories and Events

Status: **Future**

- Photos, stories, and voice memories
- Life events and heritage timeline
- Wedding and family event coordination
- RSVP and announcements
- Explicit audience controls for every memory

## Milestone 8: Private Family Social Layer

Status: **Future**

- Family feed
- Updates, reactions, and comments
- Circles and branch audiences
- Moderation and reporting
- Notification preferences

This layer should use graph membership and permissions rather than becoming a
public social network by default.

## Milestone 9: Vamsha Relationship Intelligence

Status: **Future**

- Natural-language relationship questions
- Relationship path explanations
- Cross-language calling guidance
- Confidence and provenance
- Suggested missing relationships
- Assisted duplicate resolution

AI output must remain explainable and must not silently alter family facts.

## Technical Priorities

Near-term:

1. Define the normalized write path.
2. Implement authenticated family-scoped RLS.
3. Build profile and relationship editors.
4. Add integration tests against Supabase.
5. Establish staging and production environments.
6. Add deployment automation and observability.

Later:

1. Media storage and transformation
2. Background jobs and notifications
3. Search and graph indexing
4. Offline edits and synchronization
5. Mobile release pipelines
6. AI evaluation and safety controls

## Deferred Until the Write Model Is Safe

- Broad public launch
- Open social posting
- Automatic identity claims
- AI-generated family facts
- Uploading sensitive family archives
- Public exposure of user-created family graphs
