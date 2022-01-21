
test_that(
  "as()"
  , {
    test <- 1:4
    variable_label(test) <- "a"

    expect_identical(
      as(test, "logical")
      , as(1:4, "logical")
    )

    expect_identical(
      as(test, "integer")
      , as(1:4, "integer")
    )
    expect_identical(
      as(test, "numeric")
      , as(1:4, "numeric")
    )
    expect_identical(
      as(test, "double")
      , as(1:4, "double")
    )
    expect_identical(
      as(test, "character")
      , as(1:4, "character")
    )


  }
)
