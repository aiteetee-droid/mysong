# Intelligence Layer

## Messy Inputs the Owner Provides
- A place name + memory snippet ("Fushimi Inari, 5 am, orange gates")
- A photo description or URL
- A raw quote with attribution

## Auto-Structure Schema (stored in `inspirations.structured_json`)
```json
{
  "entities": ["Fushimi Inari", "torii gates"],
  "mood": "contemplative",
  "imagery": ["mist", "dawn", "foxes"],
  "suggested_key": "C minor",
  "rhyme_scheme": "ABAB"
}
```
`structured_json_source`: `"openai/gpt-4o"` | `structured_json_confidence`: `0.82` | `structured_json_review_status`: `"unreviewed"`

## Events to Track
- Song created / published / unpublished
- AI draft generated, accepted, rejected
- Lead captured

## Scoring (rule-based v1)
- Published songs with audio URL → priority in feed (score +2)
- Songs with accepted AI draft → score +1
- Songs with no lyrics → score −1 (show as draft only)

## What Gets Ranked
- Feed order: published date DESC by default; later swap to score DESC

## v1 vs Later
| v1 | Later |
|---|---|
| Manual lyrics only | AI draft from inspiration input |
| Static feed order | Score-ranked feed |
| No tagging | Auto mood/genre tagging |
