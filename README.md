# 🎸 SetlistApp

A real-time collaborative setlist builder for bands. Built with Rails 8, Turbo, Stimulus, and ActionCable.

**Live demo:** http://192.168.0.25:3000 *(local network)*

---

## What it does

SetlistApp helps bands plan and manage setlists together — in real time. Every change syncs instantly to everyone viewing the same setlist, no refresh needed.

### Features

- **Band management** — Create a band, invite members by email via token-based invitations
- **Song library** — Per-band song catalog with optional durations (`mm:ss`)
- **Setlist editor** — Drag-and-drop ordered list of songs and comment blocks
- **Real-time sync** — ActionCable broadcasts every change to all band members viewing the setlist
- **Set duration estimator** — Automatically totals song durations + timed breaks
- **Comment blocks** — Insert markers between songs (`-- ENCORE --`, `-- INTERMISSION --`) with optional durations
- **Per-setlist song notes** — Add notes to songs that are specific to one setlist
- **Dark mode** — Auto-detects system preference, toggle in nav
- **Landing page** — Public-facing page for unauthenticated visitors

---

## Tech stack

| Layer | Tech |
|-------|------|
| Framework | Rails 8.1 |
| Language | Ruby 3.3.11 |
| Database | PostgreSQL |
| Auth | Devise |
| Frontend | Turbo + Stimulus (no React/Vue) |
| JS bundler | Bun |
| CSS | Dart Sass (SCSS) |
| Real-time | ActionCable (async adapter in dev) |
| Ordered lists | acts_as_list |
| Drag-and-drop | SortableJS |

---

## Data model

```
User
├── has_many :memberships
└── has_many :bands (through memberships)

Band
├── belongs_to :owner (User)
├── has_many :memberships
├── has_many :songs
├── has_many :setlists
└── has_many :invitations

Membership
├── belongs_to :user
├── belongs_to :band
└── role: "owner" | "member"

Invitation
├── belongs_to :band
├── email + token + accepted_at
└── accepted via /invitations/:token/accept

Song
├── belongs_to :band
├── title
└── duration_seconds (optional)

Setlist
├── belongs_to :band
└── has_many :setlist_items (ordered by position)

SetlistItem
├── belongs_to :setlist
├── item_type: "song" | "comment"
├── song_id (nullable — only for song items)
├── content (nullable — only for comment items)
├── position (acts_as_list)
└── duration_seconds (optional — for comment items)

SetlistSongNote
├── belongs_to :setlist
├── belongs_to :song
└── content (note specific to this setlist)
```

---

## Setup

### Requirements

- Ruby 3.3.11 (via rbenv)
- Rails 8.1
- PostgreSQL
- Bun
- Node.js 20+

### Install

```bash
# Install gems
bundle install

# Install JS packages
bun install

# Set up database
bin/rails db:create db:migrate db:seed

# Build assets
bin/rails dartsass:build
bun run build

# Start server
bin/rails server -b 0.0.0.0 -p 3000
```

### Demo credentials (after seed)

```
Email:    demo@example.com
Password: password123
```

---

## Project structure

```
app/
├── channels/
│   ├── application_cable/
│   └── setlist_channel.rb        # ActionCable — broadcasts setlist updates
├── controllers/
│   ├── bands_controller.rb
│   ├── home_controller.rb        # Landing page (unauthenticated root)
│   ├── invitations_controller.rb
│   ├── memberships_controller.rb
│   ├── setlist_items_controller.rb
│   ├── setlist_song_notes_controller.rb
│   ├── setlists_controller.rb
│   └── songs_controller.rb
├── javascript/controllers/
│   ├── setlist_editor_controller.js  # SortableJS drag-and-drop
│   ├── setlist_sync_controller.js    # ActionCable subscriber
│   └── inline_edit_controller.js    # Inline editing (comments, notes)
├── models/
│   ├── band.rb
│   ├── invitation.rb
│   ├── membership.rb
│   ├── setlist.rb                # Includes broadcast_items_update
│   ├── setlist_item.rb
│   ├── setlist_song_note.rb
│   ├── song.rb
│   └── user.rb
└── assets/stylesheets/
    └── application.scss          # Full design system + dark mode
```

---

## Routes

```
GET  /                          → Landing page (unauthenticated) or bands (authenticated)
GET  /songs                     → All songs across all bands
GET  /setlists                  → All setlists across all bands

GET  /bands                     → Band list
GET  /bands/:id                 → Band overview
GET  /bands/:band_id/songs      → Songs for a band
GET  /bands/:band_id/setlists   → Setlists for a band
GET  /setlists/:id              → Setlist editor

POST /setlists/:setlist_id/setlist_items          → Add item
PATCH/DELETE                                       → Update/remove item
POST /setlists/:setlist_id/setlist_song_notes     → Add note
PATCH                                              → Update note

GET  /invitations/:token/accept → Accept band invitation

WS   /cable                     → ActionCable WebSocket endpoint
```

---

## Real-time collaboration

When any band member makes a change to a setlist:

1. The server saves the change
2. Responds to the requesting user via **Turbo Stream** (instant local update)
3. Broadcasts the updated list HTML to all other subscribers via **ActionCable** (`setlist_#{id}` channel)
4. The `setlist-sync` Stimulus controller on each other client receives the broadcast and swaps in the new HTML

Uses the `async` adapter in development (single-process). For production, switch to `solid_cable` or Redis in `config/cable.yml`.

---

## Design

Scandinavian-inspired design system — clean, minimal, bold typography, single blue accent. Full dark mode support via CSS custom properties (`var(--bg)`, `var(--text)`, etc.) toggled by `html.dark` class.

See [`BRAND_GUIDE.md`](./BRAND_GUIDE.md) for the full design system documentation.

---

## Deployment notes

- Set `SECRET_KEY_BASE` environment variable in production
- Update `config/action_cable.yml` to use Redis or solid_cable for multi-process deployments
- Update `config.action_cable.url` in `config/environments/production.rb`
- Run `bin/rails assets:precompile` for production builds
- Default Dockerfile included (Kamal-ready)
