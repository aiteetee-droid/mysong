# Agentic Layer

## Risk Levels & Actions

### Low — auto-execute (no approval)
- `tag_inspiration` — parse raw input → fill `structured_json` (mood, imagery, entities)
- `score_song` — recalculate feed score on save
- `summarise_inspiration` — one-line summary for song card subtitle

### Medium — owner sees draft, approves before save
- `draft_lyrics` — generate lyrics from structured inspiration → written to `lyrics_draft`; owner accepts/edits/rejects in admin UI
- `suggest_title` — propose title from inspiration; owner accepts or ignores

### High — always requires explicit approval
- `publish_song` — change status to 'published' (owner button only, never automatic)
- `send_lead_email` — email a captured lead (not in v1)

### Critical — human only, never automated
- `delete_song` — permanent deletion; requires confirmation dialog
- `bulk_delete_leads` — owner action only

## Named Tools (v1 → Sprint 5)
- `tool:draft_lyrics(song_id, inspiration_text)` → returns `{ lyrics_draft, confidence }`
- `tool:tag_inspiration(raw_input)` → returns `structured_json`

## Audit Log Fields
`id, created_at, actor (user_id or 'agent'), action, object_type, object_id, payload_json, outcome`

## v1 vs Later
| v1 | Later |
|---|---|
| No AI actions | draft_lyrics + tag_inspiration (Sprint 5) |
| Manual publish only | Scheduled publish |
