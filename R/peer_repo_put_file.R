peer_github_api_repo_put_file = function(repo, path, content, message, branch, sha) {

  args = list(
    endpoint = "PUT /repos/:owner/:repo/contents/:path",
    owner = ghclass::get_repo_owner(repo), repo = ghclass::get_repo_name(repo),
    path = path,
    content = base64enc::base64encode(content),
    message = message, branch = branch
  )

  if (!is.null(sha)) {
    args[["sha"]] = sha
  }

  do.call(ghclass::ghclass_api_v3_req, args)
}



peer_repo_put_file = function(repo, path, content, message = NULL, branch = NULL, sha, verbose = TRUE) {
  ghclass::arg_is_chr_scalar(repo, path)
  ghclass::arg_is_chr_scalar(message, branch, sha, allow_null = TRUE)

  if (is.null(message))
    message = ghclass::cli_glue("Adding file: {path}")

  if (is.character(content))
    content = charToRaw(content)

  res = purrr::safely(peer_github_api_repo_put_file)(
    repo = repo, path = path, content = content,
    message = message, branch = branch, sha = sha
  )

  if (verbose){
    ghclass::status_msg(
      res,
      "Added file {.val {path}} to repo {.val {repo}}.",
      "Failed to add file {.val {path}} to repo {.val {repo}}."
    )
  }

  res
}
