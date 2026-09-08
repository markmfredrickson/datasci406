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

**Copy a file before you edit it.** Put your copy in `my-work/`, keeping the
module folder around it:

```
my-work/01-integrate/project.Rmd
```

The module folder matters — the exercises load data with a path like
`../../data/fish.csv`, which only points at `data/` if your file is two levels
down. Nothing ever writes into `my-work/`: re-downloading skips it, and git
ignores it. Anything you leave outside it can be overwritten by an update.

## Layout

```
modules/     one folder per module — exercises and project templates
data/        datasets, loaded from a module folder as ../../data/<file>
my-work/     yours; create it, git ignores it
```

## A note on this repository

It is generated — every file here is published from the instructor's materials
repository by a script. Pull requests and issues here will not be addressed.
