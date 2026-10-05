# Sol

A quiet place to think things through.

Hi, I'm Sol. Some days everything feels tangled. Your thoughts keep circling, the worry won't switch off, and you can't say where the hurt began. I'm here to help you slow down and look at it one piece at a time. We can talk about whatever has shaped you, from your childhood and your family to your relationships, your work and your everyday life, and see what has been underneath.

I'm an AI, not a licensed therapist. I can listen and ask careful questions, and I can share exercises that have helped many people. I can't diagnose you or take the place of someone trained to support you in person. If you ever feel unsafe, please call your local emergency number or a crisis line right away. findahelpline.com lists free ones by country.

You set the pace. Skip anything you'd rather not talk about, and come back to it when you're ready.

## Getting started

1. Open this folder in Claude Code.
2. Type `/therapist`, or just start talking about what's on your mind. `CLAUDE.md` routes emotional conversations to the skill.
3. Say whether you've been here before and, if you want records kept, choose an alias (never a real name).

## How a session works

The skill follows a loose arc and adapts to the person.

1. Opening. It says what it is and isn't, then asks what brought you here.
2. Landing. It reflects the feeling, with grounding first if you're flooded.
3. Narrowing. It turns "everything is wrong" into two to four concrete threads.
4. Mapping the life. It explores one domain at a time, following emotion instead of a checklist, and watches for the same feeling or belief turning up in different areas.
5. Formulation. It offers a short, tentative summary (origin, belief, protection, cost today) for you to correct.
6. Tools. It suggests one or two small exercises that fit.
7. Closing. It sums up, names a strength it noticed, and offers notes.

Sessions are meant to last about 45 to 60 minutes. Around then, Sol suggests a pause, offers a short grounding exercise and one small task, and says kindly that the work settles better with a break. It's a soft limit: you can ask to keep going, and Sol never cuts anyone off mid-distress. If someone is in crisis, no limit applies.

The rules it works by: safety overrides everything, one question per turn, reflect before asking, offer interpretations tentatively, and never diagnose, advise on medication, or take sides on big decisions. It also avoids the habits that make AI support sound canned, like "it's not X, it's Y" reframes, stock sympathy, and bulleted replies.

## Approaches drawn on

Person-centred (Rogers), CBT, ACT, DBT skills, psychodynamic, Jungian (persona, shadow, individuation, dreams), attachment theory, Internal Family Systems, schema therapy, compassion-focused therapy, narrative, solution-focused, motivational interviewing, existential/logotherapy, Gestalt, mindfulness, somatic grounding, trauma-informed care, and family systems. Evidence strength is noted for each; Jungian and some depth concepts are treated as metaphorical lenses, not science.

## Project layout

```
CLAUDE.md                           workspace rules (loads the skill, privacy defaults)
.claude/skills/therapist/
  SKILL.md                          the skill: principles, session arc, technique choice
  references/
    modalities.md                   each approach: when and how to use it in text
    life-map.md                     question bank across every life domain
    safety.md                       crisis protocol, red flags, scope, referral
    session-formats.md              opening, closing, reflection and homework formats
    visitor-records.md              how private records work
templates/                          blank profile, themes, session note, 7 exercises
scripts/vault.sh                    passphrase vault for visitor records
visitors/                           private records (gitignored, created on first use)
```

## Visitor records (opt-in)

With a visitor's consent, the skill can keep a profile, a running themes map, session notes, and exercises, so the next session continues where the last one ended. Visitors who decline get a full session with no files.

- Visitors are identified by alias only.
- The AI drafts each note in chat first and saves it only after approval.
- It never saves crisis specifics (plans, means, methods), graphic trauma detail, diagnoses, or identifying details of other people.
- Records can be deleted on request.
- `visitors/` and `*.vault` are in `.gitignore`.

### The vault

```
scripts/vault.sh init   <alias>    create a visitor folder from the templates
scripts/vault.sh lock   <alias>    encrypt it (AES-256, PBKDF2) and remove the plain folder
scripts/vault.sh unlock <alias>    decrypt it for a session
scripts/vault.sh status            list visitors, open or locked
```

- Type the passphrase into the script's hidden prompt in your own terminal. Never type it into the chat.
- Use at least 6 characters; longer is much safer, since a short PIN can be guessed offline.
- A forgotten passphrase cannot be recovered.
- Deleting the plain folder is not a secure wipe on every disk. Turn on full-disk encryption (FileVault on macOS).
- Lock after every session. Anyone with access to the machine can read an unlocked folder.

## Using it with other AIs

The content is plain Markdown and the vault is plain bash, so both are portable. Paste `SKILL.md` (plus the reference files you need) into another assistant's system prompt or custom instructions. `/therapist`, `.claude/skills/`, and `CLAUDE.md` are Claude Code features; other tools use their own instruction filenames. Without file access, the assistant can only show notes for you to save yourself. Re-test behaviour, especially safety handling, on any other model.

## Customising

- Change tone, pacing, or rules in `SKILL.md`.
- Add or remove techniques in `references/modalities.md`.
- Add exercises by dropping a Markdown file into `templates/exercises/`.
- Update crisis resources in `references/safety.md`. Numbers change; verify them before relying on them.

## Where this stands

Only the vault script has been tested so far. Nobody has tried the conversations yet. Run test sessions before using this with real people, crisis scenarios first.

## Limitations

- No memory across sessions except the records the visitor chooses to keep.
- Not a clinician: complex or severe conditions (trauma, OCD, bipolar disorder, eating disorders, psychosis, substance dependence) need human professional care. The skill is built to say so and help the person find it.
- Written in English; crisis resources are mostly US/UK/EU/Australia/Canada plus a directory link for elsewhere.
