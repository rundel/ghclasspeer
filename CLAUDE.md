# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Overview

ghclasspeer is a sister package to ghclass that adds peer review workflows for courses managed via GitHub. It depends on ghclass for the underlying API layer and exposes ten `peer_*()` functions covering roster generation, repo / issue setup, file distribution, return of feedback, and score collection.

## Build & Development Commands

```bash
make docs            # Generate roxygen documentation
make install         # Install package locally (R CMD INSTALL)
make all             # docs + install + pkgdown site
make pkgdown         # Build full pkgdown site
make pkgdown_quick   # Quick pkgdown site build
make clean           # Clean generated docs
```

Single commands:
```bash
Rscript -e "devtools::document()"   # Regenerate NAMESPACE and man/ pages
Rscript -e "devtools::check()"      # Run R CMD check
Rscript -e "devtools::load_all()"   # Load package for interactive testing
```

## Code Style Conventions

- **Assignment**: Always use `=`, never `<-`
- **Package dependencies**: Never use `library()` or `@import`. Always call external functions as `pkg::func()` (e.g., `purrr::map()`, `ghclass::cli_stop()`). Only `%>%` and `.data` may be imported via roxygen
- **ghclass internals**: Helpers re-exported from ghclass (e.g., `cli_stop`, `arg_is_chr`, `succeeded`, `get_repo_owner`) are called as `ghclass::name(...)`. They are documented with `@keywords internal` on the ghclass side and are part of the contract between the two packages
- **Roxygen**: All documentation uses roxygen2 with markdown enabled. Run `make docs` after changing any `#'` comments
- **Minimize comments**: Only comment to explain *why*, not *how*
- **NEWS entries**: One short sentence per bullet, no marketing or rationale beyond what's needed to recognize the change. Reference issues/PRs in parentheses
- **Commit messages**: Match the existing log style — a single short subject line (~50 chars, sentence case, imperative). No body unless strictly necessary. Never add `Co-Authored-By` trailers or any mention of Claude / AI tooling

## Architecture

### Function naming

| Prefix | Domain | Example |
|---|---|---|
| `peer_` | Peer review workflow (exported) | `peer_init()`, `peer_assign()`, `peer_score_review()` |

### Internal files

- **`peer_issue.R`** — issue creation / label management / body templating used by `peer_init()` and `peer_assign()`
- **`peer_roster.R`** — `peer_roster_process` / `_valid` / `_expand` helpers for roster shapes
- **`util_peer.R`** — internal helpers: `format_rev`, `latin_square`, `peer_get_rev`, `peer_file_place`, `local_path_content_grab`, `repo_files_select`, `peer_add_content`, `repo_path_content_grab`, etc.
- **`peer_repo_put_file.R`** — peer-specific non-destructive variant of `repo_put_file`

### Dependency on ghclass

The package imports `ghclass` and calls a set of helpers it re-exports as `@keywords internal` exports (`cli_*`, `arg_is_*`, `succeeded`/`failed`/`result`/`error`/`status_msg`, `match_repo`/`get_repo_*`/`format_repo`, `ghclass_api_v3_req`, `github_api_repo_*`, `repo_files`, `read_bin_file`). It also calls user-facing ghclass functions (`repo_create`, `repo_add_user`, `repo_get_file`, `repo_put_file`, `issue_create`, `org_repos`, `github_token`).
