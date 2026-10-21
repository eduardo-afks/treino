-- DUDU FITNESS — esquema inicial para Supabase (PostgreSQL)
-- Execute este arquivo no SQL Editor do seu projeto Supabase.
-- Segurança: cada sessão pertence ao usuário autenticado; RLS impede acesso cruzado.

create extension if not exists pgcrypto;

create table if not exists public.workout_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  workout_day text not null check (workout_day in ('mon','tue','wed','thu','fri')),
  workout_day_name text not null,
  focus text not null,
  completed_at timestamptz not null default now(),
  exercises jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

create index if not exists workout_sessions_user_completed_idx
  on public.workout_sessions (user_id, completed_at desc);

alter table public.workout_sessions enable row level security;

drop policy if exists "Users can read own workout sessions" on public.workout_sessions;
create policy "Users can read own workout sessions"
  on public.workout_sessions for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Users can insert own workout sessions" on public.workout_sessions;
create policy "Users can insert own workout sessions"
  on public.workout_sessions for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Users can update own workout sessions" on public.workout_sessions;
create policy "Users can update own workout sessions"
  on public.workout_sessions for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete own workout sessions" on public.workout_sessions;
create policy "Users can delete own workout sessions"
  on public.workout_sessions for delete
  to authenticated
  using (auth.uid() = user_id);

-- Não habilite acesso anônimo às sessões. Faça login antes de gravar ou consultar.
