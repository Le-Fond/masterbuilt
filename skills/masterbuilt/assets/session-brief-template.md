# Brief for a builder session

Prompt:

    Work only on ticket T00 of <project>.
    Your checkout is the git worktree `<absolute path>` (branch `<branch>`, base `<integration branch>`).
    Do all work there.
    Read `<plan folder>/tickets/T00-STATUS.md` if it exists, then `tickets/T00.md`, then its required reading.
    Build exactly what the ticket asks, edit only the files it owns, commit as you go, never push.
    Write results to `T00-STATUS.md` as you go. When every acceptance check has a real result, set
    `State: READY FOR AUDIT`, commit, and stop. A design gap is a question in STATUS, not your decision.
    Done looks like: <files that exist, checks that passed, STATUS state>.

Background (for a session that has not seen the planning conversation):

    <One paragraph: what the product is, how the project is split, who merges.>
    <The project-wide rules: no production, no secrets or user data in logs, protected files, test command,
    known failing tests on the base and how to compare (by name, not by count).>

Send follow-ups to the same session; it has the context. One fix round looks like:

    T00 audit round 1 came back RETURN. Findings are appended to your STATUS. My decisions:
    1. B1 (fix): <what to change>.
    2. B2 (authorised / not changed): <why>.
    Record what you did under "Round 1 resolution", re-run the affected checks, commit, and stop.
