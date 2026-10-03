-- Bandar Kacau database setup.
-- Run this once in your Supabase project: SQL Editor > New query > paste > Run.
-- It is safe to run again; it only creates what is missing.

create table if not exists public.players (
  id          uuid primary key references auth.users (id) on delete cascade,
  name        text not null check (char_length(name) between 1 and 16),
  cash        bigint not null default 0 check (cash between 0 and 100000000),
  jobs        integer not null default 0 check (jobs between 0 and 100000),
  best_jump   real not null default 0 check (best_jump between 0 and 30),
  updated_at  timestamptz not null default now()
);

-- Added for the Wardrobe & Garage: each player's character, accessories and car.
alter table public.players
  add column if not exists look jsonb check (look is null or pg_column_size(look) < 4096);

create index if not exists players_cash_idx on public.players (cash desc);
create index if not exists players_jump_idx on public.players (best_jump desc);

-- Row Level Security: everyone can read the leaderboard,
-- but each player can only create and change their own row.
alter table public.players enable row level security;

drop policy if exists "Leaderboard is public" on public.players;
create policy "Leaderboard is public"
  on public.players for select
  using (true);

drop policy if exists "Players create their own row" on public.players;
create policy "Players create their own row"
  on public.players for insert
  to authenticated
  with check ((select auth.uid()) = id);

drop policy if exists "Players update their own row" on public.players;
create policy "Players update their own row"
  on public.players for update
  to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

grant select on public.players to anon, authenticated;
grant insert, update on public.players to authenticated;
