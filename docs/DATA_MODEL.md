# Data Model

## songs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid (nullable) | owner scope — populated at lock-down sprint |
| created_at | timestamptz | default now() |
| title | text NOT NULL | |
| status | text | 'draft' \| 'published' |
| inspiration_type | text | 'place' \| 'photo' \| 'quote' \| 'picture' |
| inspiration_source | text | raw source text or URL |
| inspiration_image_url | text | optional image link |
| lyrics | text | owner-written final lyrics |
| audio_url | text | optional embed URL |
| lyrics_draft | text | **AI field** |
| lyrics_draft_source | text | e.g. 'openai/gpt-4o' |
| lyrics_draft_confidence | numeric | 0–1 |
| lyrics_draft_review_status | text | 'unreviewed' \| 'accepted' \| 'rejected' |

## inspirations
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid (nullable) | |
| created_at | timestamptz | |
| song_id | uuid FK → songs.id | cascade delete |
| type | text | matches inspiration_type |
| raw_input | text | what the owner typed |
| image_url | text | |
| location_name | text | for 'place' type |
| structured_json | jsonb | **AI field** — parsed structure |
| structured_json_source | text | |
| structured_json_confidence | numeric | |
| structured_json_review_status | text | |

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid (nullable) | |
| created_at | timestamptz | |
| email | text UNIQUE NOT NULL | |
| source_song_id | uuid FK → songs.id | which song triggered sign-up |
| notes | text | |

## RLS
- v1: permissive read + write for all tables (demo-first)
- Lock-down sprint: replace with `auth.uid() = user_id` for writes; keep public read on `songs` where `status = 'published'`
