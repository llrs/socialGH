
comment <- function(x) {
    c(text = x$body, created = x$created_at, updated = x$updated_at,
      association = x$author_association, user(x$user),
      id = url2id(x$issue_url))
}

user <- function(x) {
    c(user = x$login, type = x$type, admin = x$site_admin)
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
    c(n_comments = x$comments, assigned = x$created_at, user(x))
}

issue <- function(x) {
2
    c(assignees = simplify(x$assignees, assignees),
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
      user = user(x$user),
      text = x$body,
      id = x$number)
}

event <- function(x) {
    c(issue = issue(x$issue), event = c(name = x$event, date = x$created_at, user(x$actor)))
}
