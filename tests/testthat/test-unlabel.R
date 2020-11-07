context("unlabel()")

test_that(
  "unlabel.default()"
  , {
    x <- letters
    variable_label(x) <- "Label to be removed"

    expect_identical(
      unlabel(x)
      , letters
    )
  }
)

test_that(
  "unlabel.data.frame()"
  , {
    x <- npk
    variable_label(x) <- list(N = "Nitrogen", yield = "Yield", P = expression(italic(P)))

    expect_identical(
      unlabel(x)
      , npk
    )
  }
)
