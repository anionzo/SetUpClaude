# Assignment <id or name> — <project> — rev 1
Role: Engineer | Scout (read-only) | Reviewer (read-only) | Architect (blind design)
Knowns task: <id | none>

Rules: **every section must have content**; write "none" rather than leave it empty. To change an assignment, issue the next `rev`; never edit in place. Write the content in Vietnamese.

## Outcome
<the end result to achieve, one paragraph>

## Must hold
<extracted from the contract, decisions and protocol: what must not be violated>

## Decided (with reasons)
<decisions already settled that the Peer does not reopen in this assignment>

## Unknown
<what the Lead is also unsure about; the Peer may investigate and report>

## Scope
- Write: <files/folders>
- Read-only: <files/folders>
- Stop and ask (`DECISION_REQUEST`) if: <conditions, e.g. needs a file outside scope, needs a schema change>

## Acceptance criteria
1. <measurable, checkable>
2. ...

## Out of scope
<things the Peer may notice but must not do in this assignment>

## Verification
- Commands: `<test>`, `<lint>`
- Base SHA: <record at start>

## Reply
Six-cell report as in `peer.md`, kind `RESULT` | `CHALLENGE` | `DECISION_REQUEST` | `BLOCKED`, written to `inbox\<agent-name>-report.md`, under 4000 characters, then end the turn.
