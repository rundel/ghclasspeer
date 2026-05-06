# ghclasspeer

<!-- badges: start -->
[![R-CMD-check](https://github.com/rundel/ghclasspeer/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rundel/ghclasspeer/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

> **Status: experimental and untested.** This package is a work-in-progress port of the peer review workflow from the `peer_review` branch of [ghclass](https://github.com/rundel/ghclass) into a standalone sister package. None of the functions have been exercised against a live course yet — expect rough edges, and please do not rely on this in production until it has been validated.

`ghclasspeer` extends [ghclass](https://github.com/rundel/ghclass) with tools for setting up, distributing, collecting, and scoring peer review assignments for courses hosted on GitHub.

## Installation

```r
# install.packages("remotes")
remotes::install_github("rundel/ghclasspeer")
```

Requires `ghclass (>= 0.4.0)`.

## Usage

A typical peer review cycle uses these exported functions in roughly this order:

1. `peer_roster_create()` — generate a roster file with randomized author/reviewer assignments.
2. `peer_init()` — create review repositories on GitHub and apply review labels.
3. `peer_assign()` — distribute author files to reviewers and open review issues.
4. `peer_file_add_aut()` / `peer_file_add_rev()` — push additional files (e.g. rating or review forms) into author or reviewer repos.
5. `peer_form_create_review()` / `peer_form_create_rating()` — generate blank Rmd feedback forms.
6. `peer_return()` — return completed review feedback to authors and open rating issues.
7. `peer_score_review()` / `peer_score_rating()` — collect scores from completed forms into a CSV.

Each function is documented with `?peer_*`. All functions assume you have a configured GitHub token — see `ghclass::github_set_token()`.

## License

GPL (>= 3)
