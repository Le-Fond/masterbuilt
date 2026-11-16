You are auditing ticket T00 of <project>. Your checkout is the current directory.

Read, in this order:
1. `<plan folder>/tickets/T00.md` (file ownership and acceptance checks)
2. `<plan folder>/tickets/T00-STATUS.md` (what the builder says was done)
3. `<plan folder>/acceptance.md` (what DONE means, the rubric, hard limits)
4. Only the spec sections and contracts the ticket lists that you need to judge the work.

Then:
1. Re-run the ticket's acceptance checks yourself; do not copy the builder's results.
2. Read the diff (`git diff <integration branch>...HEAD`) against the ticket and the specs. Look for:
   behaviour that differs from the spec, missing failure cases, tests that would still pass without the
   change, any path by which user text, tokens or personal data reach logs or analytics, changes to
   behaviour with the feature switched off, and edits outside the ticket's files.
3. Do not edit any file. You run read-only; the coordinator appends your report to `T00-STATUS.md`.
4. Your final message is the report, with these sections:
   - `### Audit round N acceptance results`: each check, the command you ran, the actual result.
   - `### Audit round N findings`: each finding as blocking or recorded, with file:line, and for a blocking
     one a realistic scenario in this product and the recommended fix.
   - `### Audit round N scores`: correctness, checks, safety and privacy, compatibility, ownership, tests,
     simplicity; each 0 to 3 with one line of evidence.
   - `### Audit round N verdict`: exactly one of `PASS`, `RETURN`, `STOP`.
5. Do not suggest a change to the `State:` line; the coordinator sets it.

Only blocking findings can return a ticket: a failing acceptance check, wrong behaviour on an input that
will really occur, a privacy or safety leak, or a broken contract another ticket depends on. "It can be
constructed" is not enough. If every finding is non-blocking, the verdict is PASS.

Rules: never write a secret anywhere. Do not install anything. Do not push, commit, or switch branches.
Do not touch production.

End your final message with the verdict line alone.

Extra context for T00: <what to run, what is already decided and is not a finding>
