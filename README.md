# DSH Work

> A local-first office agent workspace built on DeepSeek Harness.

DSH Work turns project sources into reviewable deliverables. It is designed for
knowledge work such as research, analysis, reporting, spreadsheet preparation,
and presentation drafting.

> **Status: foundation phase.** This repository documents the product and
> architecture direction. It does not yet ship a production-ready office
> workflow or desktop application.

## What DSH Work is

DSH Work is a community project that uses [DeepSeek Harness (DSH)](https://github.com/deepseek-ai/deepseek-harness)
as the agent runtime. It translates DSH's composable runtime concepts into an
office workflow that a knowledge worker can review and control.

```text
Project sources
  -> Research and analysis roles
  -> Draft deliverables
  -> Review, citations, and approval
  -> Exported report, spreadsheet, or presentation
```

The first intended workflow is **sources to deliverables**: collect files and
research, create a cited draft, review it with a human, then export an editable
office document.

## What it is not

- Not an official DeepSeek product or a replacement for Microsoft Office.
- Not a generic chat wrapper around DSH.
- Not an unattended system that can send, publish, overwrite, or delete work
  without an explicit approval policy.

## Why DeepSeek Harness

DSH is useful here because its runtime is composed from plugins, profiles,
agent presets, tools, workflows, and subagents instead of a fixed assistant.

| DSH primitive | DSH Work concept |
| --- | --- |
| Workspace | Project, client folder, or research case |
| Agent preset | Researcher, analyst, writer, or reviewer |
| Plugin | Document parser, citation service, Office generator, or connector |
| Session | One work thread inside a project |
| Workflow | A repeatable multi-role office procedure |
| Approval | Permission to publish, send, overwrite, move, or delete |
| Subagent | A bounded specialist working for another role |

Read the [architecture](docs/architecture.md) for the intended runtime shape
and the [product positioning](docs/product-positioning.md) for the business
boundary.

## Initial scope

The first release should make one workflow dependable rather than claim to
automate every office task:

1. Create a local project from a folder.
2. Add PDF, DOCX, XLSX, PPTX, and web sources.
3. Choose a work role or a small role team.
4. Produce a cited report, spreadsheet, or presentation draft.
5. Inspect the sources, changes, and final output before export.

Email, calendar, IM, Drive, Notion, and enterprise connectors belong after the
local document workflow is reliable.

## Repository map

```text
docs/
  architecture.md          Runtime and product boundaries
  product-positioning.md   Target user, scope, and differentiation
  seo-geo.md               Public-discovery and factual-content policy
llms.txt                   Machine-readable project summary
```

## Project relationship

DSH Work is an independent community project. "DeepSeek Harness" and "DSH"
refer to the upstream open-source runtime; use of those names here does not
imply endorsement, partnership, or official support from DeepSeek.

## Contributing

The product needs evidence-backed contributions in four areas: DSH profile and
plugin composition, document ingestion, editable deliverable generation, and
review/approval UX. Before proposing a feature, verify that it supports the
sources-to-deliverables workflow rather than adding a generic agent capability.

## Search and AI-discovery notes

The project intentionally publishes factual, versioned technical material for
both conventional search and AI retrieval. See [SEO and GEO](docs/seo-geo.md)
and [llms.txt](llms.txt).
