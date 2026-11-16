---
name: masterbuilt
description: Run a large project as a coordinator - plan it, split it into tickets, assign each ticket to the right model in its own session and worktree, have a second model audit, then merge. Use this whenever a job has more than about three independent pieces, touches several areas of a codebase, or the user says things like "plan this upgrade", "break this down", "split the work across sessions", "run these in parallel", "use cheaper models for the easy parts", "finish everything automatically", or asks how to save tokens on a big build. Also use it when resuming a project that already has tickets and STATUS files.
---

# Masterbuilt: plan, split, assign, audit, merge

One strong session coordinates. It never builds the whole project itself. It writes the plan, cuts it into
tickets, hands each ticket to a separate session, has a different model audit the result, and merges. The
coordinator reads STATUS files and diffs, never the builders' transcripts, so its own context stays small
for the whole project.

Use it when the work has more than about three independent pieces. For anything smaller the overhead
(writing tickets and contracts) costs more than it saves: just do the task.

## The loop

### 1. Plan
Write the design before any code, in a plan folder inside the repo (for example `docs/plan/<project>/`):

- an overview: what is being built and what is deliberately left out;
- the **contracts** between parts: API shapes, flag and event names, file formats. Tickets code against the
  contracts, not against each other's unfinished work, which is what lets them run at the same time;
- acceptance rules: what "done" means, and the audit rubric;
- a decisions file: what the user decided (in their words, dated), and what is still open, each with a
  recommendation. Tickets build to the recommendation, so nothing waits on an answer.

Ask the user only the questions that change the shape of the plan, a few at once, each with a recommendation.

### 2. Split into tickets
A ticket is one piece that a session with no memory of this conversation can finish alone. Use
`assets/ticket-template.md`. The parts that matter most:

- **Files it owns.** The exact list. A session may edit nothing else.
- **Depends on.** Which tickets must be merged first.
- **Acceptance checks.** Concrete commands or steps with an expected result.
- **Resume block.** Five lines that are enough to start or restart the ticket.

A ticket is never bound to a session. Any session can pick it up from its STATUS file, so a crashed or
full session costs nothing.

### 3. One owner per shared file
Two open tickets never edit the same file. When two tickets need the same file, either order them, or one
of them writes the change it needs under "Requests for shared files" in its STATUS and the coordinator
applies it at merge. Write the owner of every shared file into the plan. This rule is what makes parallel
sessions safe; merge conflicts are the symptom of skipping it.

### 4. Assign by difficulty
Give each ticket the cheapest model that will do it well:

| Work | Goes to |
|---|---|
| Design, contracts, coordination, tickets where judgment decides the outcome | the strongest model |
| Well-specified building against a contract | a cheaper, capable model |
| Auditing | a different model family from the one that built it |

Example mapping: Claude Fable coordinates and designs, Claude Opus builds, OpenAI Codex audits and never
builds. The names matter less than the rule: the expensive model is spent on thinking and review, and the
auditor is not the author.

### 5. Run in parallel
Start every ticket whose dependencies are merged, each in its own git worktree and its own session, with a
short brief (`assets/session-brief-template.md`). Keep at most one session per group of files that cannot
be split (for example one app ticket at a time if they all touch the project file).

A session writes its results to its STATUS file as it goes (`assets/status-template.md`) and stops at
`State: READY FOR AUDIT`. A design gap is a question in STATUS, not something the builder decides.

### 6. Audit
A session's report is a claim, not proof. When a ticket reports ready:

1. Check for yourself that every acceptance check has a result and the diff stays inside the ticket's files.
2. Have the auditor re-run the checks and read the diff (`assets/audit-prompt-template.md`). The auditor
   appends findings, scores and one verdict to STATUS. It edits no code.
3. At most two rounds. Only a **blocking** finding returns a ticket: a failing acceptance check, wrong
   behaviour on an input that will really occur, a privacy or safety leak, or a broken contract another
   ticket depends on. "It can be constructed" is recorded, not fixed. Auditors over-defend; the coordinator
   judges each finding and may keep a behaviour as a recorded decision.
4. Send a returned ticket back to the session that built it (it has the context), with your decision on
   each finding. Small mechanical fixes the coordinator may make directly.

### 7. Merge
Merge the ticket into the integration branch, re-run its tests there, apply shared-file requests, update
the board (`assets/board-template.md`), remove the worktree, and start whatever the merge unblocked.

### 8. Stop at the user's steps
Production changes, account or store steps, purchases and human judging are never done by a ticket.
Collect them and bring them to the user together, with the exact step and its rollback.

## Reporting to the user

Name the step you are on in its own words ("splitting into tickets", "assigning T07 to the cheaper model",
"auditing T03", "merging", "starting what this unblocked"), then say what happened in a line or two. Report
audit findings honestly, including the ones you chose not to fix and why.

## Why this saves time and tokens

- Each session loads one ticket, not the project, so its context is short and cheap.
- Most of the building is done by the cheaper model.
- Independent tickets run at once instead of in a queue.
- A second model finds the bugs the builder's own tests were written to pass.
- The coordinator's context holds the plan and the board, so it can run the project for days.

## Where it goes wrong

- **Too small a job.** Planning overhead exceeds the saving. Do it directly.
- **No clean seams.** If every piece touches the same files, parallel sessions gain little; order the
  tickets and run them one after another instead.
- **Thin tickets.** A ticket missing its file list or checks produces a session that guesses. Fix the
  ticket, not the session.
- **Trusting reports.** Always look at the diff and the STATUS before auditing or merging.
- **Late integration.** Each ticket is tested alone. Plan an explicit end-to-end drill ticket and an
  assembly ticket that runs the full suites on the merged branch.
- **A hung auditor.** Run it with input closed and in the background; if it writes nothing for far longer
  than earlier audits took, stop it and run it again.
