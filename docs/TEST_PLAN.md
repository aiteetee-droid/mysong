# Test Plan

## Core Success Scenario (manual)
1. Open the live domain as an anonymous visitor → feed loads with ≥1 published song card
2. Click a song card → single song page shows title, lyrics, inspiration type + source
3. If audio URL present → embed renders (or graceful fallback text)
4. Open `/admin/songs/new` → fill title, select inspiration type "quote", paste a quote, write lyrics, set status "published" → Submit
5. Return to `/songs` → new song appears in feed immediately
6. Open `/admin/songs` → click Edit on the new song → change one lyric line → Save → verify change on public page
7. Click Publish toggle → song disappears from public feed; toggle again → reappears
8. Delete the song → confirm dialog → song removed from DB and feed

## Lead Capture
9. On `/songs` footer, enter a valid email → submit → success message appears
10. Open `/admin/leads` → email appears in list
11. Submit same email again → "already subscribed" message (not a server error)

## Empty States
12. Unpublish all songs → `/songs` shows empty-state message + CTA (not a blank page)
13. No leads yet → `/admin/leads` shows "No leads yet" message

## Error States
14. Submit new song form with blank title → inline validation error, no DB write
15. Submit lead form with invalid email format → inline error, no DB write
16. Simulate DB timeout (disable Supabase connection) → feed shows friendly error banner, does not crash

## After Lock-Down Sprint
17. Unauthenticated `POST /api/songs` → 401 response
18. Visit `/admin` without session → redirect to `/login`
19. Anonymous visitor loads `/songs` → still works (published songs readable)
