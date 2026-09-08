# DATASCI 406 — Computational Methods in Statistics and Data Science

Course files for students.

Instructor: Mark M. Fredrickson (mfredric@umich.edu)

This repository holds the files you open in RStudio — session exercises,
project templates, and datasets. PDFs of course slides can be found at:


## Getting the files

Open RStudio. In the console run:

```r
source("https://markmfredrickson.github.io/datasci406/sync.R")
```

The first time, it creates a `datasci406` folder and tells you where it is —
open `datasci406.Rproj` inside it. After that, run the same line (or
`datasci406_sync()`, which is already loaded) whenever new material is
announced, and it will bring your folder up to date.

It will not overwrite your work:

- Anything in `my-work/` is left alone entirely.
- If you have edited a course file, **your version stays**. The new one is
  saved next to it as `<file>.new` so you can compare the two.
- It tells you exactly what was added, updated, or withdrawn.

### Other ways, if you prefer

Download the ZIP in a browser —
<https://github.com/markmfredrickson/datasci406/archive/refs/heads/main.zip> —
unzip, open `datasci406.Rproj`. Or, in RStudio with `usethis` installed:

```r
usethis::use_course("https://github.com/markmfredrickson/datasci406/archive/refs/heads/main.zip")
```

Both give you the same folder, but neither is careful about work you have
already done — re-downloading overwrites course files. `sync.R` is the one to
use once you have started working.

**If you already use git**, clone instead and `git pull` for updates. Nothing
here ever needs pushing back.

```bash
git clone https://github.com/markmfredrickson/datasci406.git
```

## Working on the files

Open `datasci406.Rproj` first. It sets your working directory to the top of
this folder, which is what makes the data paths in the exercises resolve.

**Work in `my-work/`.** Sync has already put your own copy of each exercise
there:

```
my-work/01-integrate/01-monte-carlo-integration-exercises.Rmd
```

Edit those, not the ones in `modules/`. Sync copies a file into `my-work/` once
and then leaves it alone forever — it will never overwrite anything you have
written there, however many times you run it. Want a clean copy of something?
Delete yours and sync again.

The originals under `modules/` keep updating, so you can always compare your
version against the current one. Anything you edit *outside* `my-work/` can be
overwritten by an update.

## Layout

```
modules/     one folder per module — exercises and project templates
data/        datasets, loaded from a module folder as ../../data/<file>
my-work/     your copies of the exercises; sync never overwrites these
```

## A note on this repository

It is generated — every file here is published from the instructor's materials
repository by a script. Pull requests and issues here will not be addressed.
