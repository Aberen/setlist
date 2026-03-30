# SetlistApp — Brand Guide

> Version 1.0 · March 2026

---

## 1. Brand Overview

### Mission
**SetlistApp helps bands stop arguing about the setlist and start playing.**

We make collaborative setlist building fast, simple, and enjoyable — for the band in a garage rehearsal space and the touring act managing a 40-city run.

### Brand Personality

| Trait | What it means |
|-------|---------------|
| **Direct** | We say what we mean. No marketing fluff, no filler words. |
| **Playful** | Music is fun. Our UI should feel like it. |
| **Confident** | Opinions baked in. We made choices so you don't have to. |
| **Reliable** | It works. Every time. No spinner anxiety. |
| **Human** | Built by people who've played in bands, not a committee. |

### Target Audience
- **Primary**: Working musicians — bands at every level, from bedroom projects to touring acts
- **Secondary**: Band managers, tour managers, venue production staff
- **Not for**: Solo artists with no collaboration needs, enterprise event companies

### Brand Voice & Tone

**Voice** (consistent, always true):
- Confident without being arrogant
- Witty without trying too hard
- Technical when needed, plain English always preferred

**Tone** (shifts with context):
- **UI copy**: Terse, action-oriented
- **Empty states**: Warm, encouraging
- **Errors**: Helpful, never blaming the user
- **Marketing**: Punchy, benefit-first

---

## 2. Logo & Wordmark

### Concept
The logo is the 🎸 emoji paired with the **SetlistApp** wordmark in DM Sans 800 weight. The emoji grounds it in music immediately — no abstraction needed.

```
🎸 SetlistApp
```

### Wordmark Specs
- Font: DM Sans, weight 800
- Letter spacing: -0.01em
- No extra tracking or kerning modifications

### Usage Rules

**Do:**
- Use on dark backgrounds: `🎸 SetlistApp` in `#ffe566` (yellow) or `#ffffff`
- Use on light backgrounds: `🎸 SetlistApp` in `#1a1a1a`
- Maintain minimum clear space of 16px on all sides
- Minimum size: 120px wide

**Don't:**
- Don't stretch, skew, or rotate
- Don't change the emoji to a different instrument
- Don't use on busy photographic backgrounds
- Don't apply drop shadows to the wordmark
- Don't use weight lighter than 700

### Logo Variations

| Variant | Background | Wordmark color |
|---------|------------|----------------|
| Primary Light | `#fffdf7` cream | `#1a1a1a` |
| Primary Dark | `#0f0f11` | `#ffe566` yellow |
| Nav (standard) | `#09090b` | `#ffe566` yellow |
| Monochrome Light | white | `#1a1a1a` |
| Monochrome Dark | `#1a1a1a` | `#ffffff` |

---

## 3. Color Palette

### Primary Palette

#### Cream — Background
```
Hex:  #fffdf7
RGB:  255, 253, 247
HSL:  48°, 100%, 98%
```
**Use for:** Page background, warm off-white canvas. Not pure white — the slight warmth is intentional and communicates "handcrafted" over "corporate."
**Don't use for:** Text, borders on interactive elements.

---

#### Black — Text & Borders
```
Hex:  #1a1a1a
RGB:  26, 26, 26
HSL:  0°, 0%, 10%
```
**Use for:** All body text, all borders on interactive elements, offset block shadows.
**Don't use for:** Body backgrounds (use cream instead). Not pure `#000000` — slightly softer.

---

#### Yellow — Primary Accent / CTA
```
Hex:  #ffe566
RGB:  255, 229, 102
HSL:  48°, 100%, 70%
```
**Use for:** Primary buttons, hover highlights, nav brand in dark mode, active state indicators.
**Don't use for:** Body text (fails contrast), backgrounds behind small text.
**The HEY connection:** This is the same warm yellow that 37signals uses. It says "action" without aggression.

---

#### Yellow Dark — Active / Hover state of Yellow
```
Hex:  #f5c800
RGB:  245, 200, 0
HSL:  49°, 100%, 48%
```
**Use for:** Hover state of primary buttons, pressed/active state.

---

### UI Colors

#### Purple — Focus & Links
```
Hex:  #7c3aed
RGB:  124, 58, 237
HSL:  263°, 83%, 58%
```
**Use for:** Focus rings (3px, 25% opacity), inline text links, active form borders.

---

#### Green — Success
```
Hex:  #22c55e
RGB:  34, 197, 94
HSL:  142°, 71%, 45%
```
**Use for:** Success flash messages, positive confirmations.

---

#### Red — Danger
```
Hex:  #ef4444
RGB:  239, 68, 68
HSL:  0°, 83%, 60%
```
**Use for:** Danger button borders, error flash messages, destructive action indicators.

---

### Dark Mode Palette

#### Dark Background
```
Hex:  #0f0f11
RGB:  15, 15, 17
```
Base page background in dark mode. Nearly black, slight blue-grey undertone.

#### Dark Surface
```
Hex:  #1c1c1f
RGB:  28, 28, 31
```
Cards, modals, nav. One step up from background.

#### Dark Surface Alt
```
Hex:  #27272a
RGB:  39, 39, 42
```
Hover states, secondary surfaces, striped rows.

#### Dark Border
```
Hex:  #3f3f46
RGB:  63, 63, 70
```
Replaces `#1a1a1a` borders in dark mode. Still visible, not hairline.

---

### Color Don'ts
- ❌ Don't use yellow as a text color on white (fails WCAG AA)
- ❌ Don't use gradients between palette colors on UI elements
- ❌ Don't introduce new accent colors without updating this guide
- ❌ Don't use opacity-based color variations — use the explicit palette values

---

## 4. Typography

### Typefaces

#### DM Sans — Primary UI Font
```css
font-family: "DM Sans", "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
```
A geometric sans-serif with personality. Friendly at small sizes, punchy at display sizes.

| Weight | Name | Usage |
|--------|------|-------|
| 400 | Regular | Body text, secondary labels |
| 500 | Medium | Nav links, table content |
| 700 | Bold | Subheadings, button labels, form labels |
| 800 | ExtraBold | Page headings, brand wordmark |

#### DM Mono — Monospace
```css
font-family: "DM Mono", "Fira Code", "Menlo", monospace;
```
Used for: token display, code snippets, setlist position numbers.

### Type Scale

| Name | Size | Weight | Use |
|------|------|--------|-----|
| `4xl` | 2.5rem / 40px | 800 | Hero headlines |
| `3xl` | 2rem / 32px | 800 | Page titles (h1) |
| `2xl` | 1.5rem / 24px | 700 | Section headers |
| `xl` | 1.25rem / 20px | 700 | Card titles, h2 |
| `lg` | 1.1rem / 17.6px | 700 | Subheadings, h3 |
| `base` | 1rem / 16px | 400 | Body text |
| `sm` | 0.875rem / 14px | 400/700 | Labels, secondary |
| `xs` | 0.8rem / 12.8px | 600 | Badges, caps labels |

### Rules

- **Headings**: Always weight 800, letter-spacing `-0.02em`, line-height `1.15`
- **Body**: Weight 400, line-height `1.65`
- **Labels**: Weight 700, size `0.875rem`
- **Buttons**: Weight 700, size `0.875rem`
- **Uppercase text**: Only for micro-labels (badges, section sub-titles), never body copy

---

## 5. Spacing & Layout

### Base Grid: 8px

All spacing is a multiple of 4px (with 8px as the base unit).

| Token | Value | Usage |
|-------|-------|-------|
| `space-1` | 4px | Icon gaps, tight inline spacing |
| `space-2` | 8px | Button internal padding (vertical), small gaps |
| `space-3` | 12px | List item padding, form element gaps |
| `space-4` | 16px | Standard padding, card inner gap |
| `space-5` | 20px | Container horizontal padding |
| `space-6` | 24px | Section internal spacing |
| `space-8` | 32px | Between related sections |
| `space-10` | 40px | Between major page sections |
| `space-12` | 48px | Auth page top padding |
| `space-16` | 64px | Page bottom padding |

### Layout

- **Max content width**: 960px
- **Container padding**: 20px horizontal
- **Nav height**: ~48px (sticky)
- **Page top padding**: 40px
- **Page bottom padding**: 64px

---

## 6. Visual Style — The 37signals DNA

### The Core Idea

SetlistApp's visual language is borrowed deliberately from 37signals. The aesthetic communicates:

> *"We're confident enough to use thick black borders. We didn't round everything into oblivion. We made decisions."*

This is the antidote to Bootstrap cards and shadcn/ui default everything. It has **opinions**.

### Borders

```scss
// Always this. Never 1px, never rgba, never border-light on interactive elements.
border: 2px solid #1a1a1a;

// Light borders only for: table row dividers, section separators (non-interactive)
border-bottom: 1px solid #e5e7eb;
```

**Rule**: Every button, card, input, and modal gets `2px solid #1a1a1a`. It gives the UI weight and presence.

### Block Shadows (Offset, No Blur)

```scss
$shadow-sm: 2px 2px 0 #1a1a1a;   // small elements, sm buttons
$shadow:    3px 3px 0 #1a1a1a;   // cards, standard buttons
$shadow-md: 4px 4px 0 #1a1a1a;   // hover state
$shadow-lg: 6px 6px 0 #1a1a1a;   // modals, auth card
```

No `blur` value. Ever. The hard offset shadow reads as physical depth — like a sticker on a desk.

### Hover & Active States

```scss
// Hover: lift up and left, shadow grows
&:hover {
  transform: translate(-1px, -1px);
  box-shadow: 4px 4px 0 #1a1a1a;
}

// Active/pressed: push down
&:active {
  transform: translate(1px, 1px);
  box-shadow: none;
}
```

This creates a tactile "button press" feel without JavaScript.

### Border Radius

| Context | Radius |
|---------|--------|
| Buttons, inputs, badges | `8px` |
| Cards, list containers | `12px` |
| Auth card, modals | `16px` |
| Pills (badges, tags) | `9999px` |

**Never** use `border-radius: 0` on interactive elements. **Never** go above `16px` on containers.

### No Gradients on UI

Backgrounds are flat. The depth comes from borders and shadows, not gradients. The only acceptable gradient is a very subtle page background texture if added intentionally.

---

## 7. Component Patterns

### Buttons

```
Primary   → Yellow background (#ffe566), black border, black text
Secondary → White background, black border, black text
Danger    → White background, red border, red text → fills red on hover
Dark      → Black background, white text (used in nav contexts)
```

**Sizes:**
- Default: `padding: 9px 18px`, `font-size: 0.875rem`
- Small (`btn-sm`): `padding: 5px 12px`, `font-size: 0.8rem`

**Rules:**
- Label is always a verb: "Add Song", "Delete Band", "Save Note"
- Never "Submit", "OK", "Confirm" as standalone labels
- Destructive actions always use `btn-danger` — never primary yellow

---

### Forms

```
Label     → 0.875rem, weight 700, color #1a1a1a
Input     → 2px border, 8px radius, 10px/14px padding, block shadow
Focus     → Purple border + 3px purple ring at 25% opacity
Error     → Red background (#fef2f2), red border, red text
Hint      → 0.8rem, muted color, below the input
```

**Rules:**
- Every input has a visible label — no placeholder-only fields
- Error messages appear inline below the field, not in a modal
- Hint text explains *why*, not just *what*

---

### Cards (Band Cards)

```
Background:  white (#ffffff)
Border:      2px solid #1a1a1a
Border radius: 12px
Shadow:      3px 3px 0 #1a1a1a
Hover:       translate(-1px, -1px), shadow grows to 4px
Padding:     20px 24px
```

Card structure: info on left (title + meta), actions on right.

---

### Item Rows

Used in song lists, member lists, setlist lists.

```
Container:  border 2px, border-radius 12px, overflow hidden
Row:        padding 10px 20px, border-bottom 1px light
Hover:      background #f3f0e8 (warm tint)
Actions:    right-aligned, flex gap 8px
```

---

### Badges

```
Background:  #fef3c7 (amber-100)
Color:       #92400e (amber-800)
Border:      2px solid #1a1a1a
Border-radius: 9999px
Font:        0.7rem, weight 700, uppercase, letter-spacing 0.06em
Padding:     2px 10px
```

Used for: ownership indicators, roles. Not for status (use flash for that).

---

### Flash Messages

```
Notice (success):
  Background: #dcfce7   Border: #16a34a   Text: #14532d

Alert (error/warning):
  Background: #fee2e2   Border: #dc2626   Text: #7f1d1d

Shared:
  Padding: 10px 20px, border 2px, border-radius 8px, shadow-sm
  Font: 0.9rem, weight 600
```

---

## 8. Setlist Editor Patterns

The setlist editor is the core of the product. Its visual design needs to communicate structure and order clearly.

### Song Rows
- **Title**: `1rem`, weight `700`, full black
- **Position number**: `0.75rem`, `DM Mono`, tabular numerals, color `#9ca3af`
- **Note pill**: Amber background (`#fffbeb`), amber border (`#fde68a`), `0.82rem` text, appears below title
- **Delete**: `✕` button, right-aligned, `btn-danger btn-icon`, only visible on hover

### Comment Rows
- **Background**: `#fefce8` warm yellow
- **Left border**: `4px solid #f5c800` — the visual indicator it's a break/note, not a song
- **Text**: `0.9rem`, weight `700`, color `#854d0e`, italic
- **Hover**: slightly darker warm yellow
- **Edit**: inline, via `inline-edit` Stimulus controller

### Drag Handle
- Character: `⠿` (Braille pattern)
- Color: `#9ca3af` light grey
- Cursor: `grab` / `grabbing` on active
- Size: `1.15rem`
- Positioned left of position number

### Ghost (Dragging State)
```scss
opacity: 0.45;
background: #ede9fe; // purple-100
border-color: #7c3aed;
```

---

## 9. Dark Mode Philosophy

### This is not an inverted palette

Dark mode isn't `filter: invert(1)`. Every dark value was chosen deliberately:

| Light | Dark | Why |
|-------|------|-----|
| `#fffdf7` cream | `#0f0f11` | Warm near-black, not pure black |
| `#ffffff` white | `#1c1c1f` | Surface, not background |
| `#f3f0e8` warm tint | `#27272a` | Hover state, maintains warmth |
| `#1a1a1a` borders | `#3f3f46` | Still visible, not aggressive |
| `3px 3px 0 #1a1a1a` | `3px 3px 0 #000000` | Pure black in dark = right |

### What stays the same
- **Yellow accent** (`#ffe566`) — it pops in both modes, no change needed
- **Purple focus** (`#7c3aed`) — visible on both backgrounds
- **Block shadow structure** — just color changes to `#000`
- **Border width** — still 2px, still present

### Setlist in dark mode
- Comment rows: `#1c1a06` background (very dark amber), `#fde68a` text — warmth preserved
- Song note pills: `#1c1a06` background, `#fde68a` text
- Drag ghost: `#2e1065` dark purple

### Toggle behaviour
- Inline `<script>` in `<head>` applies `.dark` class before paint — zero flash
- `localStorage` key: `'setlist-theme'`  →  `'dark'` or `'light'`
- Falls back to `prefers-color-scheme` if no saved preference

---

## 10. Writing Style

### Principles
1. **Verb-first buttons** — the action is the label
2. **Short labels** — if it's more than 3 words, reconsider
3. **Blame the system, not the user** — errors say what went wrong, not what the user did wrong
4. **Empty states encourage** — they don't apologise for emptiness

### Copy Examples

#### Empty States
```
No bands yet.
Create your first band and start building setlists.
[Create a Band →]

Your setlist is empty.
Add songs and comments below to build your set.

No songs in your library.
Add a song to get started — you can always edit titles later.
```

#### Error Messages
```
✗ That email is already taken.
✗ Password must be at least 6 characters.
✗ Band name can't be blank.
✗ You're not a member of that band.
```

Not:
```
❌ ActiveRecord::RecordInvalid: Validation failed
❌ Error 422: Unprocessable Entity
```

#### Confirmations
```
Delete "World Tour Night 1"?
This will remove the setlist and all its items. This cannot be undone.
[Delete] [Cancel]
```

#### Success Flashes
```
✓ Band "The Rocking Stones" created!
✓ Invitation sent to keef@example.com.
✓ Setlist updated.
✓ Song deleted.
```

---

## 11. What NOT to Do

### Visual
- ❌ No Tailwind utility class soup — use semantic SCSS classes
- ❌ No gradients on buttons, cards, or inputs
- ❌ No soft `box-shadow: 0 4px 12px rgba(0,0,0,0.1)` — use offset block shadows
- ❌ No border-radius above `16px` on containers
- ❌ No full pill-shaped buttons (`border-radius: 9999px`) — only on badges
- ❌ No hover color changes on buttons without the transform/shadow lift
- ❌ No icons without labels on primary actions (icon-only is fine for destroy/close)

### Typography
- ❌ No ALL CAPS for body text or headings
- ❌ No font-weight below 400 in the UI
- ❌ No more than 2 font sizes in a single component
- ❌ No centered body text (only auth cards, empty states)

### Copy
- ❌ No "Please enter your..." — just say what's needed
- ❌ No "Successfully..." prefix on flash messages — just the action
- ❌ No exclamation marks on error messages
- ❌ No corporate jargon ("leverage", "synergy", "utilize")
- ❌ No passive voice in CTAs

---

## 12. Inspiration & References

| Source | What we borrow |
|--------|---------------|
| **37signals / Basecamp** | Chunky borders, block shadows, warm palette, opinionated design |
| **HEY.com** | Yellow accent usage, bold typography, functional density |
| **Notion** | Clean information hierarchy, inline editing patterns |
| **Linear** | Keyboard-first interactions, fast perceived performance |
| **Figma** | Drag-and-drop interaction patterns, handle affordances |

### Key reads
- [37signals Design Philosophy](https://37signals.com/manifesto)
- *Getting Real* by 37signals — especially chapters on less software, less features
- *Refactoring UI* by Adam Wathan & Steve Schoger — for spacing and hierarchy decisions

---

*This guide is a living document. Update it when the design evolves. The worst brand guide is one that's out of date.*
