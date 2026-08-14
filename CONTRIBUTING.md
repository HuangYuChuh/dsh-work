# Contributing to DSH Work

DSH Work is in its foundation phase. Contributions should make the first
sources-to-deliverables workflow more reliable, reviewable, or composable.

## Before opening a pull request

1. Explain the user problem the change addresses.
2. State whether the change belongs to a DSH profile, preset, plugin, workflow,
   document pipeline, or review/approval experience.
3. Identify data handling and approval implications for file writes, external
   calls, publishing, sending, moving, or deleting.
4. Add verification that a reviewer can reproduce without private credentials.

## Contribution boundaries

- Preserve the upstream DeepSeek Harness runtime boundary; do not add a fork
  unless a documented upstream limitation makes it necessary.
- Prefer structured document APIs over shell-only Office manipulation.
- Treat project files, web pages, and extracted document text as untrusted
  input.
- Do not claim a feature is available until it can be run and verified from a
  fresh checkout.

For product proposals, open a GitHub issue with a representative source,
desired editable deliverable, expected review step, and possible approval
action.
