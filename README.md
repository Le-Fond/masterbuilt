# masterbuilt

A Claude Code skill for running a large project as a coordinator: **plan, split, assign, audit, merge**.

One strong session writes the plan and cuts it into tickets. Each ticket is built by a separate session in
its own git worktree, by the cheapest model that will do it well. A different model audits each result.
The coordinator merges and starts whatever that unblocked.

It is meant for jobs with more than about three independent pieces. On smaller jobs the planning costs more
than it saves.

## What is in it

- `skills/masterbuilt/SKILL.md`: the method, when to use it, and where it goes wrong.
- `skills/masterbuilt/assets/`: templates for a ticket, a STATUS file, a builder brief, an audit
  prompt and the board.

## Install

Copy the skill folder into your Claude Code skills directory:

```bash
git clone https://github.com/AgentPlutus/masterbuilt.git
cp -r masterbuilt/skills/masterbuilt ~/.claude/skills/
```

Or, from the zip: unzip it and run `sh masterbuilt/install.sh`.

Then ask Claude Code to plan a large piece of work, or say "use masterbuilt".

## The eight steps

1. **Plan.** Design, contracts between parts, acceptance rules, decisions with recommendations.
2. **Split into tickets.** Goal, files owned, dependencies, acceptance checks, resume block.
3. **One owner per shared file.** Order the tickets or route the change through the coordinator.
4. **Assign by difficulty.** Strongest model designs and reviews; a cheaper one builds; another audits.
5. **Run in parallel.** One worktree and one session per ticket.
6. **Audit.** Re-run the checks, read the diff, two rounds at most, only blocking findings return a ticket.
7. **Merge.** Re-run tests on the merged branch, update the board, start what was unblocked.
8. **Stop at the user's steps.** Production, account steps and judging go to the user, together.
