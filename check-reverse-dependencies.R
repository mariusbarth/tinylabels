
temporary_directory <- tempdir()
devtools::build(path = temporary_directory)

result <- tools::check_packages_in_dir(
  dir = temporary_directory
  , reverse = list(
    repos = getOption("repos")["CRAN"]
    , recursive = TRUE
  )
  , Ncpus = parallel::detectCores()
  , clean = TRUE
)
summary(result)

