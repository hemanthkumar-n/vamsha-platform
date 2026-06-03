# Vamsha Product Strategy Handoff for Codex

## Product Positioning

Vamsha is not a traditional family tree app.

Traditional family tree products answer:

> Who is connected to whom?

Vamsha answers:

> Who is this person to me?

Every feature must support viewer-centric relationship intelligence.

---

## Core Product Principle

Relationship is not fixed.

Relationship is projected from the viewer.

Example:

Divya Bharathi:

- Viewer = Hemanth → Sister
- Viewer = Yuvan → Aunt
- Viewer = Keerthi → Sister-in-law
- Viewer = Sudha Rani → Daughter

Same person.  
Different viewer.  
Different relationship.

---

## Vamsha Differentiator

Existing genealogy tools focus on:

- ancestry records
- family trees
- DNA
- historical people
- memories
- branch navigation

Vamsha focuses on:

- living family understanding
- viewer-relative relationships
- Indian cultural kinship terms
- privacy-aware family graph
- branch expansion
- relationship projection
- family memory context

---

## Current Strategic Priority

Do not build auth, Supabase, AI, monetization, search, invitations, or social features yet.

Current priority:

> Browser-visible family web + relationship projection demo.

The user must visually understand:

> This person is related to me like this.

---

## Current Product Milestones

Completed:

- Founder family web canvas
- Viewer-centric hierarchy
- Family connector layer
- Founder graph domain model
- Identity claim model
- Relationship projection foundation
- Hemanth relationship projections
- VRI documentation
- Flutter analyze passing
- Flutter test passing

Current active branch:

text feature/relationship-projection-engine 

Important tag:

text vri-hemanth-v1 

---

## Current Domain Model

Important concepts:

text PersonEntity FamilyUnit RelationshipEdge IdentityClaim RelationshipResolver RelationshipProjection RelationshipProjectionService ViewerContext 

Do not treat surname or family name as the primary relationship truth.

Person is primary.

Relationships are projected.

---

## Critical Identity Example

Sudha Rani demonstrates why Vamsha is different.

Birth identity:

text Mamidi Sudha Rani 

After marriage:

text Natakam Sudha Rani 

She is not two people.

She is one person with name history, aliases, and multiple relationship contexts.

For Hemanth:

text Sudha Rani → Mother 

For Yuvan:

text Sudha Rani → Grandmother 

For Prasad:

text Sudha Rani → Wife 

For Narendranath:

text Sudha Rani → Daughter-in-law 

For Sudha Rani viewing Narendranath:

text Narendranath → Father-in-law / Mamayya 

---

## Next Product Feature

Build:

text Relationship Projection Demo Screen 

Purpose:

Show that the same person has different meanings depending on viewer.

---

## UX Requirement

Screen should show:

text Viewing As: [ Hemanth ▼ ] 

Then relationship list/cards.

When viewer changes to Sudha Rani, same target people must show different relationships.

Example:

Viewer = Hemanth:

text Sudha Rani → Mother Prasad → Father Divya → Sister Keerthi → Spouse Yuvan → Son 

Viewer = Sudha Rani:

text Subbarao → Father Samarajamma → Mother Prasad → Husband Hemanth → Son Divya → Daughter Narendranath → Father-in-law / Mamayya Lakshmikanthamma → Mother-in-law / Athamma 

---

## Files Likely Involved

text mobile_app/lib/features/family/domain/relationship_projection.dart mobile_app/lib/features/family/domain/relationship_projection_service.dart mobile_app/lib/features/family/presentation/relationship_projection_demo_screen.dart mobile_app/lib/main.dart mobile_app/test/widget_test.dart 

---

## Components Needed

text ViewerSelector ProjectionList ProjectionCard CulturalRelationshipBadge 

---

## Data Needed

Minimum viewer list:

text hemanth sudha 

Minimum target list:

text sudha prasad divya keerthi yuvan narendranath lakshmikanthamma subbarao samarajamma 

---

## Acceptance Criteria

### Visual

- Viewer selector is visible.
- Relationship cards are visible.
- Cultural relationship chip appears where available.
- UI clearly says who the current viewer is.

### Functional

- Viewer can switch between Hemanth and Sudha.
- Relationship labels update instantly.
- Graph data is not duplicated.
- No backend dependency.
- No Supabase dependency.

### Code

- Projection labels come from RelationshipProjectionService.
- Widgets should not hardcode relationship labels.
- flutter analyze passes.
- flutter test passes.

---

## Do Not Build Yet

Do not build:

text Authentication Supabase persistence AI assistant Search Invitations Notifications Messaging Monetization DNA Automatic matching Memories Large graph traversal engine 

Not yet.

First prove:

> Same person, different viewer, different relationship.

---

## Codex Collaboration Protocol

Codex should only implement one small milestone at a time.

Before generating code, Codex should answer:

1. What files will change?
2. What behavior will change?
3. What will not be touched?
4. How will we test it?

After code changes, Codex should provide:

bash flutter analyze flutter test git status 

Expected output must be clean before moving to next task.

---

## Current Next Task for Codex

Build the Relationship Projection Demo Screen.

Goal:

> Make Vamsha’s core idea visible in the browser.

No backend.  
No database.  
No AI.  
No auth.  
Only local demo using current domain service.

---

## Codex Handoff

### Goal

Create a browser-visible Relationship Projection Demo Screen showing viewer-centric relationship intelligence.

### Files likely involved

text mobile_app/lib/features/family/presentation/relationship_projection_demo_screen.dart mobile_app/lib/features/family/domain/relationship_projection.dart mobile_app/lib/features/family/domain/relationship_projection_service.dart mobile_app/lib/main.dart mobile_app/test/widget_test.dart 

### Components needed

text ViewerSelector ProjectionCard ProjectionList CulturalRelationshipBadge 

### Data model changes

No new model required for this step.

Use existing:

text RelationshipProjection RelationshipProjectionService 

### UI behavior

User selects viewer.

Example:

text Viewing As: Hemanth 

Cards show:

text Sudha Rani → Mother Prasad → Father Divya → Sister 

When viewer changes:

text Viewing As: Sudha Rani 

Cards update:

text Narendranath → Father-in-law / Mamayya Lakshmikanthamma → Mother-in-law / Athamma Hemanth → Son 

### Acceptance criteria

- Viewer selector works.
- Relationships update without reload.
- Cultural terms display where present.
- No backend dependency.
- flutter analyze passes.
- flutter test passes.

### Do-not-build list

text Auth Supabase AI Search Invites Social feed Memories Monetization Large graph traversal Automatic matching 