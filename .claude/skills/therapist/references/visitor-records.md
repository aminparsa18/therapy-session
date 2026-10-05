# Visitor Records

Records give the skill continuity across sessions. They are **opt-in**, **private**, and **owned by the visitor**.

## Layout

```
visitors/                       gitignored, never committed
  <alias>.vault                 encrypted record (when locked)
  <alias>/                      plain folder, exists only while unlocked
    profile.md                  consent, goals, what helps, what to avoid
    context.md                  life facts and "already covered" questions
    themes.md                   running pattern map
    sessions/YYYY-MM-DD.md
    exercises/<name>.md
templates/                      blank documents, safe to commit
scripts/vault.sh                init | unlock | lock | status
```

## Passphrase handling (important)
- The visitor types the passphrase into `scripts/vault.sh` in a terminal themselves. **Never ask for the passphrase in the chat, never type it, never store it.** Anything typed in chat ends up in the transcript.
- You cannot unlock a vault. Ask the visitor to run: `scripts/vault.sh unlock <alias>`, and tell you when it's open.
- Be honest about limits: a short PIN can be guessed offline; a longer passphrase is much safer. Encryption protects files at rest; full-disk encryption (FileVault, BitLocker) adds real protection. If they forget the passphrase, the records cannot be recovered.

## Session start
1. Ask: "Have we met before? What alias should I look under?" Aliases only, not real names. Suggest a made-up one (2-32 chars: lowercase letters, digits, `-`, `_`).
2. **Returning, vault locked:** ask them to run the unlock command. Once confirmed, read `profile.md`, `context.md`, `themes.md`, and the last 1 to 2 session notes. Open with a short, human recap and ask how the week went and how the last step landed. Do not recite the file. If `context.md` is missing (folder made before it existed), offer to create it from `templates/context.md` and fill it from what they tell you over the session.
3. **Returning, folder already open:** read it the same way.
4. **New visitor, wants records:** explain in plain words what gets saved, where (this computer, in this folder, encrypted when locked, excluded from git), that they approve every note before it is saved, and that they can have anything deleted. If yes, they run `scripts/vault.sh init <alias>` (or you may run it for them with their permission; it needs no passphrase). Fill `profile.md` together, including the consent lines. `context.md` fills in over the first sessions.
5. **Declines:** run a normal session with no files. This must work equally well.
6. Other people may use this computer. Tell new visitors that anyone with access to the machine can see an *unlocked* folder and the encrypted file, so they should lock after each session.

## During the session
- Don't read or write files mid-conversation unless it serves them. Stay present.
- Use `themes.md` privately to spot patterns; bring hypotheses back tentatively.

### Memory discipline (don't make them repeat themselves)
- Before asking a factual or background question, check what you loaded at the start. If the record answers it, don't ask. Use it: "You mentioned the night shifts last time. Is that still the pattern?"
- Prefer an update question over the original question. Facts under `Check before assuming`, or last confirmed over about 3 months ago, get a quick "is that still so?".
- Check `Already covered` before asking any intake-style question (sleep, food, family, work, past therapy, what helped before). Ask only what changed.
- Keep a running list in the conversation of new facts, changes, and questions you asked and they answered. You will need it at session end.
- Never read a fact back in a way that sounds like a file. Weave it in the way a person who remembers would.
- A record can be wrong or out of date. If they correct you, accept it immediately and fix the record at session end.

## Session end
1. Offer: "Would you like me to write up today's session and any exercises?"
2. **Draft first, in the chat**, from `templates/session-note.md`. Let the visitor edit, cut, or refuse. Save only after approval.
3. Exercises: offer 1 or 2 matching the work, filled with their own material where helpful, from `templates/exercises/`. Copy into `exercises/` with a date in the filename. Explain what each is for and that doing it is optional. When they return with a completed one, read it with their permission and work from it.
4. Update `context.md`, `themes.md` and `profile.md` with the visitor's agreement (only what they've confirmed):
   - Show the proposed changes in chat as a short list: **added**, **changed**, **removed**. Don't paste whole files.
   - Add new facts under the right heading with the month, move answered intake questions into `Already covered`, mark facts that may change under `Check before assuming`, and delete facts they've corrected.
   - Keep the file compact. Merge and shorten rather than append forever. Context describes the visitor now; the history lives in session notes.
5. Remind them to lock: `scripts/vault.sh lock <alias>`.

## Keeping records useful
- `context.md` is the first stop for facts, `themes.md` for patterns, session notes for what happened on a day. Don't duplicate across them.
- Session notes go to the visitor too. Include `New facts and updates` and `Where we stopped` every time, since they feed the next session's recap.
- More detail is not always better. Save what Sol needs to avoid re-asking and to follow the thread. Skip incidental detail the visitor wouldn't expect to see in their record.
- If a visitor says "don't record that", leave it out and add it to the off-limits line in `profile.md`.

## What never goes in the records
- Crisis specifics: plans, means, methods, or detail of self-harm or suicidal thinking. Record only that a safety conversation happened and which resources were shared.
- Graphic trauma detail. Record that the topic was touched and how they coped, not the content.
- Names or identifying details of third parties; use roles ("mother", "ex-partner").
- The visitor's own identifying details: real name, employer, exact address, phone, email, or account numbers. Keep work and place general ("a hospital job", "a small city").
- Diagnoses or labels. Describe patterns and behaviours.
- Anything the visitor asked not to record, or that they flagged as off-limits.

## Writing style for notes
- Written to the visitor, as their own document: first person where it's their voice ("I noticed..."), their words where possible.
- Plain, kind, brief. Hypotheses marked as hypotheses.
- Strengths included in every note.

## Deletion and withdrawal
- On request, delete any note, any exercise, or the whole visitor (the `.vault` file and any open folder). Confirm exactly what will be deleted first. Explain that a normal delete is not a secure wipe on every disk.
- Never keep records after a visitor withdraws consent.

## Reading someone else's records
Never open another visitor's folder or vault. Only the alias the current visitor gave you.
