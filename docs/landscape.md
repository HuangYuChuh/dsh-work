# DSH Office Ecosystem

This is a dated implementation snapshot, not an endorsement list. The
repositories and package metadata below were checked on 2026-08-15. DSH Work
uses these projects to understand the plugin surface and avoid duplicating
working document primitives.

## Verified projects

| Project | What we verified | Product implication |
| --- | --- | --- |
| [`Jesse-njx/dsh-cowork`](https://github.com/Jesse-njx/dsh-cowork) | A source repository with a DSH bundle, CLI, and MCP server. Its README describes bounded `doc_read`/`doc_write` operations for XLSX, PDF, DOCX, PPTX, and IPYNB, including stable cell and shape addresses. | Strong reference for safe document addressing and reuse outside DSH. Its plugin package is not published as `@dsh-cowork/plugin`, and the checkout currently targets DSH `rc.6`, so it is not a drop-in dependency for this pinned `rc.5` profile. |
| [`omdsh-dev/dsh-office`](https://github.com/omdsh-dev/dsh-office) / [`@huiliyi37/dsh-office`](https://www.npmjs.com/package/@huiliyi37/dsh-office) | A published Apache-2.0 DSH bundle. Version `0.1.6` exposes `xlsx_read/write/edit`, `pdf_create/read`, `pptx_create/read`, and `docx_create/read`; its package manifest declares a `dsh.bundle` patch. | This is the first external Office capability wired into DSH Work. The profile pins the package and explicitly enables all four families. Its older peer ranges are handled through DSH's `autoInstallPeers: false` profile contract and still require runtime verification on upgrades. |
| [`vibeinging/dsh-work`](https://github.com/vibeinging/dsh-work) | A separate Electron workbench positioned around DSH sessions, project files, data analysis, web research, MCP, and Office artifacts. | Confirms demand for a desktop workbench. DSH Work should differentiate through evidence, citations, review, and approval semantics rather than another generic shell around the runtime. |
| [`shixiliya1/dsh-rich-file-reader`](https://github.com/shixiliya1/dsh-rich-file-reader) | A DSH plugin project focused on local image, Office, and PDF reading. | Reading and ingestion are a distinct plugin boundary from structured generation and approval-aware export. |

## DSH Work boundary

These projects solve useful low-level capability gaps. DSH Work is the product
workflow above them:

```text
source files -> bounded readers -> evidence records -> role workflow
  -> editable draft -> citation/change review -> human approval -> export
```

The current repository only claims the runtime, the Office tool bundle, and the
profile composition. Evidence records, cross-format provenance, reviewer views,
and external-action approvals remain implementation work.
