# Project protocol: <tên>
status: draft · version: 1 · reviewed: <yyyy-mm-dd> · owner: user

Keep this file **under 40 lines**. The Lead reads it before assigning work and copies the relevant lines into each assignment. Peers read it once at start. Fill it in with the user the first time; write in whichever language the user prefers.

## Characteristics
- Stack: <language, framework, DB>
- Sensitivity: <real data? production? real users?>
- Knowns: <yes | no>

## Authority
- User decides: contract, merge into main branch, deploy, data deletion, significant cost, closing tasks as `done`.
- Lead decides: work split, provider/model choice, candidate acceptance.
- Peer: only within the assignment; beyond it → `DECISION_REQUEST`.

## Task classes and routing
- Small, clearly bounded → Sonnet or Gemini Flash; one Peer.
- Cross-module, lifecycle-sensitive → Sonnet; independent review by a different model family.
- Architecture lock-in → blind design with 2 Peers, Lead scores.
- Read-only scouting → Haiku or Flash low.

## Ownership and workspace
- Working branches: <naming convention>; main branch: <main/master>.
- Parallel work → one worktree per Peer, non-overlapping file scopes.
- Forbidden areas: <folders/files, e.g. applied migrations, secrets, production config>.

## Verification
- Test: `<command>` · Lint: `<command>` · Build: `<command>`
- Reports must include the commands run, exit codes and real output.

## Project anti-patterns
- <e.g. "fix whatever looks convenient nearby", "disable a failing test", "change schema without a migration">

## Evolution
- Changing this file: Lead proposes, user approves, bump `version` and update `reviewed`.
