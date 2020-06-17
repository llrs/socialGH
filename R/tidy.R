tidy <- function(x, ...){
    UseMethod("tidy")
}

tidy.comment <- function(x) {
    c(text = x$body, created = x$created_at, updated = x$updated_at,
      association = x$author_association, user(x$user))
}

user <- function(x) {
    c(user = x$login, type =x$type, admin = x$site_admin)
}

labels <- function(y) {
    vapply(y, getElement, name = "name", character(1L))
}

milestones <- function(x) {
    vapply(x, getElement, name = "milestone", character(1L))
}

tidy.assignee <- function(x) {
    user(x)
}

tidy.assigner <- function(x) {
    user(x)
}

tidy.actor <- function(x) {
    user(x)
}

tidy.assignees <- function(x) {
    c(n_comments = x$comments, assigned = x$created_at, user(x))
}
tidy.issue <- function(x) {
    if (is.named(x$assignees)) {
        assignees <- user(x$assignees)
    } else {
        browser(expr = is.list(x$assignees))
        assignees <- apply_class(x$assignees, "assignees")
    }
    if (is.named(x$assignee)) {
        assignee <- user(x$assignee)
    } else {
        assignee <- apply_class(x$assignee, "assignee")
    }
    list(assignees,
         assignee,
         label = labels(x$labels),
         state = x$state,
         milestone = milestones(x$milestone),
         n_comments = x$comments,
         id = x$number)
}

tidy.event <- function(x) {
    c(name = x$event, date = x$created_at, tidy.actor(x$actor))
}
