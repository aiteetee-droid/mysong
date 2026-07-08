create table if not exists songs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  title text not null,
  status text not null default 'draft',
  inspiration_type text not null default 'quote',
  inspiration_source text,
  inspiration_image_url text,
  lyrics text,
  audio_url text,
  lyrics_draft text,
  lyrics_draft_source text,
  lyrics_draft_confidence numeric,
  lyrics_draft_review_status text default 'unreviewed'
);

alter table songs enable row level security;
drop policy if exists "songs_v1_read" on songs;
create policy "songs_v1_read" on songs for select using (true);
drop policy if exists "songs_v1_write" on songs;
create policy "songs_v1_write" on songs for all using (true) with check (true);

create table if not exists inspirations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  song_id uuid references songs(id) on delete cascade,
  type text not null,
  raw_input text,
  image_url text,
  location_name text,
  structured_json jsonb,
  structured_json_source text,
  structured_json_confidence numeric,
  structured_json_review_status text default 'unreviewed'
);

alter table inspirations enable row level security;
drop policy if exists "inspirations_v1_read" on inspirations;
create policy "inspirations_v1_read" on inspirations for select using (true);
drop policy if exists "inspirations_v1_write" on inspirations;
create policy "inspirations_v1_write" on inspirations for all using (true) with check (true);

create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  email text not null unique,
  source_song_id uuid references songs(id) on delete set null,
  notes text
);

alter table leads enable row level security;
drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

insert into songs (id, title, status, inspiration_type, inspiration_source, lyrics) values
  ('a1b2c3d4-0001-0001-0001-000000000001', 'Kyoto at Dawn', 'published', 'place', 'Fushimi Inari shrine, 5 am, mist between the torii gates', 'Red gates in the morning mist,\nA thousand prayers I never kissed,\nThe foxes watch me find my way,\nKyoto holds me, come what may.'),
  ('a1b2c3d4-0002-0002-0002-000000000002', 'Her Polaroid', 'published', 'photo', 'An old Polaroid of a woman laughing at a 1970s beach', 'Sun-bleached colours, sandy toes,\nA laugh the whole Atlantic knows,\nYou froze a second, silver-bright,\nAnd handed me your borrowed light.'),
  ('a1b2c3d4-0003-0003-0003-000000000003', 'Neruda''s Margin', 'published', 'quote', '"I want to do with you what spring does with the cherry trees." — Pablo Neruda', 'What spring does, I''ll do the same,\nCoax your blossom, learn your name,\nNo frost will catch what we have sown,\nA thousand petals, fully blown.'),
  ('a1b2c3d4-0004-0004-0004-000000000004', 'Midnight Motorway', 'draft', 'place', 'Empty M6 motorway at 2 am, only orange sodium lights', 'Orange sky and asphalt hum,\nWhere am I from, where do I come,\nLanes stretch out like lines of thought,\nAll the miles, all the things I sought.');