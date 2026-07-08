# mysong – Product Requirements Document

## Problem
The owner wants to turn real-world inspiration — a place visited, a photo found, a quote read — into a song, then publish and manage that content on a site they fully control.

## Target User
One owner (the builder). Visitors are anonymous readers.

## Core Objects
| Object | Purpose |
|---|---|
| Song | The published artefact: title, lyrics, status, audio link |
| Inspiration | The raw source tied to a song (place / photo / quote) |
| Lead | Visitor email captured from the public feed |

## MVP Must-Haves (v1)
- [ ] Public song feed — visitors see all published songs without logging in
- [ ] Single song page — full lyrics + inspiration detail
- [ ] Owner can create, edit, delete, publish/unpublish a song
- [ ] Inspiration attached to each song (type + source text/image URL)
- [ ] Lead capture email form on the public feed
- [ ] 4 seeded demo songs so the site is not blank on first load
- [ ] Site runs on a custom domain via Vercel

## Non-Goals (v1)
- Multi-user accounts or teams
- AI lyrics generation (Sprint 5, after core works)
- Audio recording or file upload
- Visitor reactions / comments
- Payment or subscription gating

## Definition of Done
A first-time visitor opens the live domain, sees at least four published songs, clicks one, reads its full lyrics and inspiration, and the owner (via /admin) can create a new song, fill in lyrics, hit Publish, and confirm it appears immediately on the public feed — all data persisted in Supabase, no dead buttons, no sign-in wall blocking the visitor.
