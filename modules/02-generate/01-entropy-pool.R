## Reading the operating system's entropy pool from base R.
##
## macOS and Linux only. Windows has no /dev/urandom, and its equivalent
## (CryptGenRandom) is not reachable from base R, so this will not run there.
##
## The deck displays the captured output rather than running this at knit
## time. To refresh it:
##
##   Rscript -e 'source("01-entropy-pool.R", echo = TRUE, max.deparse.length = Inf)' \
##     > 01-entropy-pool.txt

## Read 8 unsigned 16-bit integers straight from the entropy pool.
con <- file("/dev/urandom", "rb", raw = TRUE)
V <- readBin(con, "integer", n = 6, size = 2, signed = FALSE)
close(con)

V

## n = 16 bits, so V / 2^n lands in (0, 1).
V / 2^16
