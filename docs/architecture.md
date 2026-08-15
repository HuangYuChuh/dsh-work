# Architecture

## Product goal

DSH Work is a product layer over DeepSeek Harness, not a fork that replaces
the DSH runtime. The product must make office work inspectable: a user should
be able to see the sources used, roles involved, files changed, and actions
awaiting approval.

## Runtime shape

```mermaid
flowchart LR
  U[Knowledge worker] --> P[Project workspace]
  P --> S[DSH session]
  S --> R[Role preset]
  R --> T[Office tools and connectors]
  R --> W[Workflow and subagents]
  T --> D[Draft deliverables]
  W --> D
  D --> V[Review: sources, citations, changes]
  V --> A[Approval policy]
  A --> E[Export or external action]
```

The technical planes remain separate:

| Plane | Responsibility | Example |
| --- | --- | --- |
| DSH host profile | Shared runtime services | Provider access, workspace policy, approval service, schedules, workflow worker |
| DSH agent preset | Per-session role composition | Researcher with web research and source-reading tools |
| DSH plugin | A replaceable capability | DOCX parser, XLSX generator, citation recorder |
| DSH Work product layer | Office language and interaction | Project, source, deliverable, reviewer, and approval views |

## Repository integration

The upstream runtime is tracked as a Git submodule at
`packages/deepseek-harness` and pinned to a reviewed commit. This keeps DSH's
large plugin graph in its own repository while making the exact runtime
version reproducible for a DSH Work checkout.

The product-owned runtime home is `.dsh/`. Its `profiles/work/package.json`
composes the upstream `@deepseek-ai/dsh-base` and
`@deepseek-ai/dsh-web-app` bundles plus the first Office bundle,
`@huiliyi37/dsh-office`. The profile's `cordis.patch.yml` inserts that bundle's
tool row, making the extension explicit and removable. `scripts/dsh-work.ps1`
sets `DSH_HOME`, selects that profile, and forwards Web arguments to the
upstream launcher.
Generated sessions, storage, profile roots, and module links stay ignored;
the profile manifest and patch layer are the versioned product contract.

### Model authentication boundary

The Models page treats provider authentication as a capability, not as a
generic API-key field. The pi-ai adapter reports whether a catalog provider
supports API keys, native OAuth, or both. DSH Work currently exposes the
provider-owned OAuth flow for `openai-codex` only.

The browser calls the loopback `llm.auth*` API with a provider and an opaque
login id. It may receive an authorization URL and progress events, but never
receives an access token, refresh token, or authorization code. pi-ai runs the
OAuth exchange, owns the localhost callback, and serializes the credential
through the DSH credential service at `.dsh/.credentials.yaml`. This keeps the
product UI independent of provider protocol details while preserving the
runtime's refresh behavior and credential redaction boundary.

This composition gives us a real browser shell, model settings, workspaces,
sessions, approvals, workflows, subagents, deliverable UI, and Office file
tools from DSH plus the external plugin. The plugin currently provides bounded
`xlsx_*`, `pdf_*`, `pptx_*`, and `docx_*` operations; citation provenance,
review UX, and approval-aware export still belong to the DSH Work product layer
and must be added with focused tests and sample office fixtures.

## Required product capabilities

### Document ingestion

Office work starts with heterogeneous files. The product needs an explicit
generic file pipeline for PDF, DOCX, XLSX, and PPTX: storage, extraction,
preview metadata, parsing limits, and safety treatment of untrusted source
content. DSH's current image-oriented attachment surface is insufficient on
its own.

### Structured deliverables

The agent must create editable output, not only markdown in a chat transcript.
Generation should use structure-aware document, spreadsheet, and presentation
libraries or dedicated Office tools. Rendering and review must feed back into
the same task before the user exports a file.

### Source and citation provenance

Every claim in a deliverable should be traceable to source files, pages,
sections, URLs, tool output, or stated model inference. The UI should clearly
separate evidence from generated interpretation.

### Office approvals

DSH Work needs policies that describe business actions rather than technical
tool names. Send email, publish, overwrite spreadsheet, move/delete a source,
and export a final deliverable are separate approval classes.

## First workflow

```text
Local project folder
  -> collect sources
  -> research and extract evidence
  -> analyze facts and data
  -> create editable draft
  -> reviewer checks citations and output
  -> human approves export
```

This deliberately excludes broad enterprise automation until document quality,
provenance, and review are reliable.

## Non-goals for the first release

- Reimplementing a full Word, Excel, or PowerPoint editor.
- Replacing the upstream DSH runtime or its plugin system.
- Allowing high-impact external actions without an approval policy.
- Shipping a terminal- and Git-centric developer UI as the primary experience
  for knowledge workers.
