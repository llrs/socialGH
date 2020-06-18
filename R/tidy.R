
user <- function(x, name = "user") {
    l <- list(user = x$login, type = x$type, admin = x$site_admin)
    names(l)[1] <- name
    l
}

comment <- function(x) {
    l <- list(text = x$body, created = x$created_at, updated = x$updated_at,
      association = x$author_association, id = url2id(x$issue_url))
    u <- user(x$user, "commenter")
    c(l, u)
}

labels <- function(y) {
    vapply(y, getElement, name = "name", character(1L))
}

url2id <- function(x) {
    strsplit(x, "/", fixed = TRUE)[[1]][8]
}

milestones <- function(x) {
    vapply(x, getElement, name = "milestone", character(1L))
}

assignees <- function(x) {
    l <- list(n_comments = x$comments, assigned = x$created_at)
    u <- user(x, "assigner")
    c(l, u)
}

issue <- function(x) {

    l <- list(assignees = simplify(x$assignees, assignees),
      assignee = simplify(x$assignee, user),
      label = labels(x$labels),
      state = x$state,
      locked = x$locked,
      milestone = milestones(x$milestone),
      n_comments = x$comments,
      title = x$title,
      created = x$created_at,
      updated = x$updated_at,
      association = x$author_association,
      text = x$body,
      id = x$number)
    u <- user(x$user, "poster")
    c(l, u)
}

event <- function(x) {
    # browser()
    i <- issue(x$issue)
    l <- list(event = x$event, date = x$created_at)
    u <- user(x$actor, "trigger")
    c(i, l, u)
}
