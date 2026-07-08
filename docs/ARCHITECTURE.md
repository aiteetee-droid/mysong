# Architecture

## Stack
- **Frontend + API routes:** Next.js 14 (App Router) on Vercel
- **Database + Auth:** Supabase (Postgres + RLS + Auth)
- **Storage (later):** Supabase Storage for inspiration photos
- **AI (later):** OpenAI via a server-side API route only

## Now vs Later
| Now | Later |
|---|---|
| Public song feed + single song page | Owner login / RLS lockdown |
| Owner CRUD via /admin (no auth wall yet) | AI lyrics drafting |
| Lead capture form | Image upload |
| Custom domain on Vercel | Lead newsletter drip |

## Key User Action — Owner publishes a new song
1. Owner opens `/admin/songs/new`
2. Form submits to `POST /api/songs` → validates fields → inserts row into `songs` table
3. Inspiration row inserted into `inspirations` (linked by `song_id`)
4. Owner hits **Publish** → `PATCH /api/songs/[id]` sets `status = 'published'`
5. Public `/songs` feed re-fetches; new song card appears
6. Visitor clicks card → `/songs/[id]` reads from `songs` + `inspirations`

## Layer Order
1. **Data** — tables, constraints, RLS policies, seed rows
2. **App logic** — CRUD API routes, form validation, status transitions
3. **Smart features** — AI draft endpoint, confidence scoring (Sprint 5+)

The site works completely if the AI layer is removed; lyrics are just a text field.
