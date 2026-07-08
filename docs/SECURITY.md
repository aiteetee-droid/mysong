# Security

## Secret Handling
- `OPENAI_API_KEY`, `SUPABASE_SERVICE_ROLE_KEY` — server-side env vars only; never referenced in any client component or exposed via API response
- Public Supabase anon key is intentionally public; it is safe only because RLS policies enforce access

## Permission Model
| Phase | Read | Write |
|---|---|---|
| v1 demo | Anyone | Anyone (permissive RLS) |
| Lock-down | Public: published songs only; leads: none | `auth.uid() = user_id` |

- After lock-down, the owner is the only authenticated user; no self-serve sign-up needed
- Admin routes (`/admin/*`) check server-side session; redirect to `/login` if unauthenticated

## Approved Tools Rule
- Agent may only call named tools defined in AGENTIC_LAYER.md
- No `eval`, no `run_any`, no raw SQL execution from agent context
- Every tool call writes an audit log row before returning

## Audit Principle
- Every meaningful state change (song created/published/deleted, lead captured, AI draft accepted/rejected) writes to `audit_logs`
- Audit rows are insert-only; no update or delete policy on that table
- If in doubt about a security decision (e.g., exposing leads data publicly), stop and review before deploying
