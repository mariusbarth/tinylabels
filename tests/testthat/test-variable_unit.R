
test_that(
  "Test difftime objects"
  , {
    t0 <- as.difftime(tim = 60, units = "secs")
    variable_label(t0) <- "Computation time"

    captured <- capture_output(print(t0))

    expect_identical(
      captured
      , "Variable label     : Computation time\nUnit of measurement: secs\nTime difference of 60 secs"
    )
  }
)
