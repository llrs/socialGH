

#' Helpers to link back to GitHub
#'
#' Create links to the issue or profile, it is vectorized
#' @param repository id/repo of the repository to link (e. ex: "llrs/socialGH")
#' @param n Issue number
#' @param id Id of the user to link (e. ex: "llrs")
#' @export
#' @rdname link
link_issue <- function(repository, n) {
    paste0("[",n, "](https://github.com/", repository, "/issues/", n,
           ")", collapse = ", ")
}

#' @export
#' @rdname link
link_profile <- function(id) {
    paste0("[", id, "](https://github.com/", id, ")", collapse = ", ")
}
