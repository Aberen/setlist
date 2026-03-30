# SetlistApp — Agent Context

This file is for MunkBot 2000. Read this when resuming work on the SetlistApp project.

---

## What this project is

A collaborative setlist builder SaaS for bands. Built by Horn and MunkBot over one evening (2026-03-30).

**Live server:** `http://192.168.0.25:3000` (Horn's local network)  
**Repo:** `git@github.com:Aberen/setlist.git`  
**App directory:** `/home/nijoergensen/.openclaw/workspace/setlist_app`

---

## Stack

- **Rails 8.1.3** monolith
- **Ruby 3.3.11** (via rbenv at `~/.rbenv`)
- **PostgreSQL** — databases: `setlist_app_development`, `setlist_app_test`
- **Bun** for JS bundling (`bun run build` → `app/assets/builds/application.js`)
- **Dart Sass** for CSS (`bundle exec rails dartsass:build` → `app/assets/builds/application.css`)
- **Turbo + Stimulus** — no React/Vue
- **Devise** for auth — views are locally scoped in `app/views/devise/`
- **ActionCable** — async adapter in dev, mounted at `/cable`
- **acts_as_list** — setlist item ordering
- **SortableJS** — drag-and-drop in `setlist_editor_controller.js`

---

## How to start the server

```bash
export HOME=/home/nijoergensen
export PATH="$HOME/.rbenv/bin:$HOME/.bun/bin:$PATH"
eval "$(rbenv init -)"
cd /home/nijoergensen/.openclaw/workspace/setlist_app
export RAILS_ENV=development
bundle exec rails server -b 0.0.0.0 -p 3000
```

The server runs in background session — check with `process(action=list)` if you need to find it.

---

## How to build assets

```bash
# CSS
bundle exec rails dartsass:build

# JS
bun run build
```

Both must be run after changes. CSS lives in `app/assets/stylesheets/application.scss` (single file, ~700 lines). JS entry is `app/javascript/application.js`.

---

## Database

```bash
# Reset and reseed
bundle exec rails db:drop db:create db:migrate db:seed

# Just migrate
bundle exec rails db:migrate

# Demo credentials after seed
# Email: demo@example.com / Password: password123
```

pg_hba.conf is set to `trust` for local connections — no password needed.

---

## Git / GitHub

SSH key is at `~/.ssh/id_ed25519_github`. Remote is `git@github.com:Aberen/setlist.git`.

```bash
cd /home/nijoergensen/.openclaw/workspace/setlist_app
git add -A
git commit -m "your message"
git push
```

**Always ask Horn if you should push after a confirmed working change.**

---

## Key files to know

| File | What it does |
|------|-------------|
| `app/assets/stylesheets/application.scss` | Entire design system — light + dark mode via CSS custom properties |
| `app/javascript/controllers/setlist_editor_controller.js` | SortableJS drag-and-drop, sends PATCH on reorder |
| `app/javascript/controllers/setlist_sync_controller.js` | ActionCable subscriber — receives broadcasts from other users |
| `app/javascript/controllers/inline_edit_controller.js` | Inline editing for comments and song notes |
| `app/controllers/setlist_items_controller.rb` | All setlist item CRUD — uses `respond_with_update` for all actions |
| `app/controllers/setlist_song_notes_controller.rb` | Song notes — same `respond_with_update` pattern |
| `app/models/setlist.rb` | Has `broadcast_items_update` — called after every change |
| `app/channels/setlist_channel.rb` | ActionCable channel — streams `setlist_#{id}` |
| `app/views/setlists/_items_list.html.erb` | The main setlist partial — re-rendered on every Turbo Stream update |
| `config/routes.rb` | Routes — note `/songs` and `/setlists` are top-level cross-band indexes |
| `BRAND_GUIDE.md` | Full design system docs |

---

## Turbo Stream pattern

Every setlist mutation (create/update/destroy on items or notes) follows this pattern:

1. Save the change
2. Call `@setlist.broadcast_items_update` → sends updated HTML to all OTHER subscribers via ActionCable
3. Respond to the requesting user with `turbo_stream.replace("setlist-items-content", partial: "setlists/items_list", ...)`

The partial `_items_list.html.erb` wraps everything in `<div id="setlist-items-content">` — this is the Turbo target.

---

## Known quirks

- `form_with url:` without a model or `scope:` doesn't namespace params. We use raw `<input name="setlist_item[field]">` HTML in forms to avoid this.
- `params.require(...).permit(...).to_h` returns string-keyed hash — always use `raw['key']` not `raw[:key]`
- ActionCable `async` adapter only works single-process (dev). For multi-process prod, switch `config/cable.yml` to Redis or solid_cable.
- The JS bundle is NOT rebuilt automatically — must run `bun run build` after JS changes.
- CSS IS NOT rebuilt automatically — must run `bundle exec rails dartsass:build` after SCSS changes.

---

## Design system summary

- **Palette:** white bg, `#0a0a0b` dark bg, `#2563eb` accent blue, all via CSS `var(--*)` tokens
- **Dark mode:** `html.dark` class on `<html>`, toggled by button in nav, persisted in `localStorage`
- **No Tailwind** — all SCSS in `application.scss`
- **Fonts:** Inter system stack
- **Borders:** `1px solid var(--border)` — subtle, no chunky offset shadows

---

## What's been built (features)

- ✅ Band management (create, invite by email, member roles)
- ✅ Song library per band with optional duration (`mm:ss`)
- ✅ Setlist editor with drag-and-drop ordering
- ✅ Real-time sync via ActionCable (all band members see changes live)
- ✅ Set duration estimator (songs + timed comment breaks)
- ✅ Comment blocks between songs (with optional duration)
- ✅ Per-setlist song notes (inline editable)
- ✅ Song track numbers skip comments
- ✅ Dark mode
- ✅ Landing page (unauthenticated root)
- ✅ Cross-band Songs + Setlists index pages (nav links)
- ✅ Devise views locally scoped

## What's NOT built yet (ideas discussed)

- ⬜ Live Mode — stripped read-only view for on-stage use
- ⬜ Setlist cloning / templates
- ⬜ Change history / activity log

---

## Horn's preferences

- Push to GitHub after every confirmed working change (ask first)
- No Tailwind, no React, no inline styles
- Scandinavian design aesthetic — clean, minimal, bold
- Direct communication — no filler, no sycophancy
- Test before claiming something is fixed
