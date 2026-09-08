# DATASCI 406 --- get the latest course files.
#
#   source("https://markmfredrickson.github.io/datasci406/sync.R")
#
# Needs nothing but R: no git, no GitHub account, no extra packages. Run it
# again whenever new material is announced.
#
# It will not overwrite your work. Anything in my-work/ is left alone entirely,
# and if you have edited a course file, your version stays put and the new one
# is saved beside it as <file>.new for you to compare.
#
# It also sets up my-work/ with your own copy of each exercise and project, so
# you can start editing immediately. Those copies are made once; a file already
# there is never replaced.

DATASCI406_URL <-
  "https://github.com/markmfredrickson/datasci406/archive/refs/heads/main.zip"

datasci406_sync <- function(dest = NULL, url = DATASCI406_URL, quiet = FALSE) {
  say <- function(...) if (!quiet) cat(..., sep = "")

  # In the project already? Sync in place. Otherwise make the folder here.
  if (is.null(dest)) dest <- if (file.exists("datasci406.Rproj")) "." else "datasci406"
  fresh <- !dir.exists(dest)
  dir.create(dest, showWarnings = FALSE, recursive = TRUE)

  say("Downloading course files ...\n")
  zip <- tempfile(fileext = ".zip")
  ex  <- tempfile()
  on.exit(unlink(c(zip, ex), recursive = TRUE), add = TRUE)
  utils::download.file(url, zip, mode = "wb", quiet = TRUE)
  dir.create(ex)
  utils::unzip(zip, exdir = ex)

  roots <- list.dirs(ex, recursive = FALSE)
  if (length(roots) != 1L) stop("unexpected archive layout; tell your instructor")
  src <- roots[[1L]]

  rel <- list.files(src, recursive = TRUE, all.files = TRUE, no.. = TRUE)
  rel <- rel[!startsWith(rel, "my-work/") & rel != ".sync-state"]

  # What the course last handed you, so an edit of yours is distinguishable
  # from a file you have simply never touched.
  state_file <- file.path(dest, ".sync-state")
  state <- character(0)
  if (file.exists(state_file)) {
    x <- utils::read.table(state_file, sep = "\t", quote = "", comment.char = "",
                           stringsAsFactors = FALSE, col.names = c("md5", "path"))
    state <- stats::setNames(x$md5, x$path)
  }
  md5 <- function(p) unname(tools::md5sum(p))
  recorded <- function(f) if (f %in% names(state)) unname(state[[f]]) else NA_character_

  added <- changed <- yours <- removed <- character(0)

  for (f in rel) {
    from <- file.path(src, f)
    to   <- file.path(dest, f)
    dir.create(dirname(to), showWarnings = FALSE, recursive = TRUE)

    if (!file.exists(to)) {
      file.copy(from, to)
      added <- c(added, f)
      next
    }
    here <- md5(to)
    if (identical(here, md5(from))) next          # already current

    if (identical(here, recorded(f))) {           # untouched by you: refresh it
      file.copy(from, to, overwrite = TRUE)
      changed <- c(changed, f)
    } else {                                      # you edited it: keep yours
      file.copy(from, paste0(to, ".new"), overwrite = TRUE)
      yours <- c(yours, f)
    }
  }

  # Files withdrawn from the course: drop only ones you never edited.
  for (f in setdiff(names(state), rel)) {
    to <- file.path(dest, f)
    if (file.exists(to) && identical(md5(to), unname(state[[f]]))) {
      unlink(to)
      removed <- c(removed, f)
    }
  }

  # Your working copies. Seeded once and then never touched again: a file is
  # copied in only if it is not already there, so nothing you have written is
  # ever overwritten. Delete one to get a fresh copy on the next sync.
  work <- file.path(dest, "my-work")
  dir.create(work, showWarnings = FALSE, recursive = TRUE)
  seeded <- character(0)
  ws_file <- file.path(src, ".worksheets")
  if (file.exists(ws_file)) {
    for (w in Filter(nzchar, readLines(ws_file, warn = FALSE))) {
      # Drop the leading modules/ so the copy sits two levels down and the
      # ../../data/ paths inside it still resolve.
      to <- file.path(work, sub("^modules/", "", w))
      if (!file.exists(to) && file.exists(file.path(src, w))) {
        dir.create(dirname(to), showWarnings = FALSE, recursive = TRUE)
        file.copy(file.path(src, w), to)
        seeded <- c(seeded, sub("^modules/", "my-work/", w))
      }
    }
  }

  utils::write.table(
    data.frame(md5 = vapply(file.path(src, rel), md5, ""), path = rel),
    state_file, sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)

  listing <- function(title, v) if (length(v)) say(title, "\n", paste0("  ", v, "\n"))
  say("\n")
  listing(paste0("New (", length(added), "):"), added)
  listing(paste0("Updated (", length(changed), "):"), changed)
  listing(paste0("No longer part of the course (", length(removed), "):"), removed)
  listing(paste0("Ready for you to work in (", length(seeded), "):"), seeded)
  if (length(yours)) {
    listing(paste0("You have edited these, so they were left as they are. The new ",
                   "version is saved beside each one as <file>.new:"), yours)
  }
  if (!length(c(added, changed, yours, removed, seeded))) say("Already up to date.\n")

  if (fresh) {
    say("\nOpen this file to get started:\n  ",
        normalizePath(file.path(dest, "datasci406.Rproj"), mustWork = FALSE), "\n")
  }
  say("\nRun datasci406_sync() again any time.\n")
  invisible(list(added = added, updated = changed, yours = yours,
                 removed = removed, seeded = seeded))
}

# Sourcing this file runs a sync straight away.
datasci406_sync()
