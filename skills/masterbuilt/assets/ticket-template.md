# T00 <short title>

## 1. Goal
One sentence: what exists when this ticket is done.

## 2. Agent and batch
Model: <strongest | builder | auditor runs>   Batch: <B1>   Depends on: <tickets, or none>

## 3. Required reading
- `<plan folder>/<spec>.md` §<section>
- `<contracts folder>/<contract>.md`

## 4. Files this ticket owns
- `<path>` (new)
- `<path>` (only <which part>)

Nothing else may be edited. A change needed elsewhere goes under "Requests for shared files" in STATUS.

## 5. What to build
The behaviour, in a short list. Point at the spec for detail rather than repeating it.

## 6. Acceptance checks
| Check | Command or steps | Expected |
|---|---|---|
| | | |

## 7. Out of scope
What a reasonable builder might add and must not.

## 8. Hard limits
No production changes. No secrets, user text or personal data in logs, fixtures or STATUS. No deleted
assertions or lowered standards to make a test pass.

## 9. Resume block
```
Work only on ticket T00 of <project>.
Read <plan folder>/tickets/T00-STATUS.md if it exists, then tickets/T00.md, then the required reading.
Your checkout is this worktree; the base branch is <integration branch>.
Do not deploy or change production.
Write results to tickets/T00-STATUS.md as you go. When every check has a result, set State: READY FOR AUDIT and stop.
```
