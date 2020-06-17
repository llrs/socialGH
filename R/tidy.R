
comment <- function(x) {
    l <- list(text = x$body, created = x$created_at, updated = x$updated_at,
      association = x$author_association, user(x$user),
      id = url2id(x$issue_url))
    names(l)[names(l) == "user"] <- "commenter"
    l
}

user <- function(x) {
    list(user = x$login, type = x$type, admin = x$site_admin)
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
    list(n_comments = x$comments, assigned = x$created_at, user(x))
}

issue <- function(x) {

    list(assignees = simplify(x$assignees, assignees),
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
      commenter = user(x$user),
      text = x$body,
      id = x$number)
}

event <- function(x) {
    # browser()
    event <- c(event = x$event, date = x$created_at, user(x$actor))
    names(event)[names(event) == "user"] <- "trigger"
    c(issue(x$issue), event)
}
