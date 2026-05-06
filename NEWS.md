# ghclasspeer (development version)

* Require `ghclass (>= 0.4.0)`; drop `Remotes:` pin and direct `gh` dependency.
* Switch `branch` defaults from `"master"` to `NULL` so calls fall through to the repository's default branch.
* Replace deprecated `purrr::cross2`, `purrr::map_df`, and `tidyr::gather`/`spread` with `tidyr::expand_grid`, `purrr::map_dfr`, and `tidyr::pivot_longer`/`pivot_wider`.
* Initial release. Lifts the peer review workflow from the `peer_review` branch of `ghclass` (`peer_init`, `peer_roster_create`, `peer_assign`, `peer_return`, `peer_file_add_aut`/`_rev`, `peer_form_create_review`/`_rating`, `peer_score_review`/`_rating`) into a sister package that imports `ghclass`.
