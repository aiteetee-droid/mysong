# Tasks & Sprints

## Sprint 1 — DB foundations + public song feed
**Goal:** The site is live with demo data; visitors can browse and read songs without logging in.

- [ ] Run migration SQL (songs, inspirations, leads + RLS v1 policies + seed data)
- [ ] `/songs` feed page — song cards (title, inspiration type badge, excerpt) — loading / empty / error / ready states
- [ ] `/songs/[id]` single song page — full lyrics, inspiration detail, audio embed if URL present
- [ ] Deploy to Vercel; confirm custom domain resolves
- [ ] Verify all 4 seeded songs are readable; no sign-in prompt blocks visitor

**Definition of Done:** A visitor on the live domain sees 4 song cards, clicks one, reads full lyrics — zero auth prompts, zero console errors.

---

## Sprint 2 — Owner create / edit / delete (core engine) ✦ v1 functional milestone
**Goal:** Owner can manage all songs end-to-end from `/admin`.

- [ ] `/admin/songs` list with New / Edit / Delete actions
- [ ] New song form: title, inspiration type + source, lyrics, audio URL, status — persists to DB
- [ ] Edit form pre-populated from DB row
- [ ] Delete with confirmation dialog — row removed, feed updates
- [ ] Publish / unpublish toggle — status flips in DB, reflected on public feed immediately
- [ ] Empty state CTA on public feed when zero published songs
- [ ] All forms: validation errors shown inline; loading state on submit; success redirect

**Definition of Done:** Owner creates a song, publishes it, confirms it on the public feed, edits lyrics, unpublishes, deletes — every action persists; no dead buttons.

---

## Sprint 3 — Lead capture
**Goal:** Visitors can leave their email; owner can see the list.

- [ ] Email sign-up widget on `/songs` feed footer
- [ ] `POST /api/leads` — validates email, inserts row, returns 200 or 409 on duplicate
- [ ] Unique constraint on `leads.email` enforced at DB level
- [ ] `/admin/leads` list page (no auth yet)
- [ ] Form: loading / success / duplicate-error / server-error states

**Definition of Done:** Visitor submits email → appears in `/admin/leads`; submitting same email again shows "already subscribed" message.

---

## Sprint 4 — Lock it down (auth + RLS)
**Goal:** Only the owner can write data; public read stays open for published songs.

- [ ] Enable Supabase Auth; create owner account
- [ ] Replace permissive RLS policies with owner-scoped write policies
- [ ] Public read policy: `songs` where `status = 'published'` only
- [ ] `/admin/*` routes redirect to `/login` if no valid session
- [ ] Assign `user_id` on existing demo rows to owner account
- [ ] Regression: public feed still loads without login

**Definition of Done:** Unauthenticated POST to `/api/songs` is rejected with 401; public feed shows only published songs; owner logs in and reaches `/admin` successfully.

---

## Sprint 5 — AI lyrics drafting
**Goal:** Owner can get an AI-drafted lyric from the inspiration, review it, and accept or reject.

- [ ] Server-side `POST /api/ai/draft-lyrics` — calls OpenAI, returns draft
- [ ] Store in `songs.lyrics_draft` + `_source` + `_confidence` + `_review_status`
- [ ] Admin song form shows draft panel: Accept / Edit / Reject buttons
- [ ] Accept → copies draft to `lyrics`, sets `review_status = 'accepted'`, writes audit log
- [ ] Reject → sets `review_status = 'rejected'`, writes audit log
- [ ] `OPENAI_API_KEY` only in server env; never in client bundle

**Definition of Done:** Owner enters an inspiration, requests draft, sees lyrics suggestion, accepts it → `lyrics` field updated in DB, audit log row present, key not visible in browser network tab.

---

## Gantt (sprint → feature lands)
```
Sprint 1 │ DB + seed + public feed + custom domain
Sprint 2 │ Owner CRUD + publish toggle          ← v1 functional
Sprint 3 │ Lead capture
Sprint 4 │ Auth + RLS lockdown
Sprint 5 │ AI lyrics drafting
```
