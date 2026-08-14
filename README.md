<h1 align="center">DSH Work</h1>

<p align="center"><strong>Turn project sources into reviewable office deliverables with DeepSeek Harness.</strong></p>

<p align="center">
  <a href="https://github.com/HuangYuChuh/dsh-work/actions/workflows/docs.yml"><img src="https://github.com/HuangYuChuh/dsh-work/actions/workflows/docs.yml/badge.svg" alt="Documentation checks"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-4D6BFE.svg" alt="MIT License"></a>
  <a href="https://github.com/HuangYuChuh/dsh-work/commits/main"><img src="https://img.shields.io/github/last-commit/HuangYuChuh/dsh-work.svg" alt="Last commit"></a>
  <a href="https://github.com/deepseek-ai/deepseek-harness"><img src="https://img.shields.io/badge/runtime-DeepSeek%20Harness-111827.svg" alt="Built on DeepSeek Harness"></a>
</p>

DSH Work is a local-first office agent workspace for analysts, researchers,
operations teams, and consultants. It turns project files and research into
cited, editable reports, spreadsheets, and presentations that a person can
inspect and approve before they leave the workspace.

> **Foundation phase:** the repository currently defines the product and
> architecture. It does not yet provide an installable desktop application or
> a production-ready office workflow.

```mermaid
flowchart LR
  A[Project sources] --> B[Specialist roles]
  B --> C[Editable draft]
  C --> D[Evidence and change review]
  D --> E[Human approval]
  E --> F[Exported deliverable]
```

## Why DSH Work

The hard part of office automation is not generating a paragraph. It is making
the path from evidence to deliverable visible enough for a professional to
trust and approve.

DSH Work uses [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness)
as a composable agent runtime. Its profiles, presets, plugins, workflows, and
subagents become business concepts such as projects, roles, sources,
deliverables, and approvals.

## The first workflow

The first release has one narrow job: **sources to deliverables**.

1. Create a local project from a folder.
2. Add PDF, DOCX, XLSX, PPTX, and web sources.
3. Assign research, analysis, writing, and review roles.
4. Produce an editable report, spreadsheet, or presentation draft.
5. Review evidence, citations, and file changes before export.

Email, calendar, IM, Drive, Notion, and enterprise connectors come later. The
document workflow must be dependable first.

## What the product must prove

- **Keep evidence visible.** Claims in a deliverable should point back to a
  source file, page, section, URL, tool result, or clearly labelled inference.
- **Keep files editable.** A useful result is a DOCX, XLSX, PPTX, or PDF that
  can be inspected and revised, not a markdown answer trapped in chat.
- **Keep consequential actions reviewable.** Exporting, publishing, sending,
  overwriting, moving, and deleting require an explicit approval policy.
- **Keep roles bounded.** A researcher, analyst, writer, and reviewer should
  have distinct tools and responsibilities instead of one opaque super-agent.

## How DSH maps to office work

| DeepSeek Harness primitive | DSH Work concept |
| --- | --- |
| Workspace | Project, client folder, or research case |
| Agent preset | Researcher, analyst, writer, or reviewer |
| Plugin | Document parser, citation service, Office generator, or connector |
| Session | One work thread inside a project |
| Workflow | A repeatable multi-role office procedure |
| Approval | Permission to export, send, publish, overwrite, move, or delete |
| Subagent | A bounded specialist working for another role |

## Current status

This is intentionally not a fake Quick Start. There is no installation command
yet because a fresh clone cannot produce a verified office deliverable. The
first public implementation milestone is a reproducible local workflow with
document ingestion, cited generation, review, approval, and editable export.

## Documentation

| Document | What it answers |
| --- | --- |
| [Architecture](docs/architecture.md) | How DSH and the office product layer fit together |
| [Product positioning](docs/product-positioning.md) | Who the product serves and what it will not become |
| [SEO and GEO foundations](docs/seo-geo.md) | How public claims stay discoverable and factual |
| [llms.txt](llms.txt) | Concise machine-readable project facts |

## For DSH builders

DSH Work will be built as a product layer over the upstream runtime, not as a
replacement for it. Contributions should strengthen one of four paths:

1. DSH office profiles, presets, and plugin composition.
2. Safe PDF, DOCX, XLSX, and PPTX ingestion.
3. Structured, editable deliverable generation and preview.
4. Citation, review, and approval UX.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the current contribution boundary.

## Project relationship

DSH Work is an independent community project. "DeepSeek Harness" and "DSH"
refer to the upstream open-source runtime; their use here does not imply
endorsement, partnership, or official support from DeepSeek.

## License

This repository is available under the [MIT License](LICENSE).
