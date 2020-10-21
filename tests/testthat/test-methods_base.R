
context(context("methods for generics from base"))

test_that(
  "droplevels.tiny_labelled-method"
  , {
    # only check consistency, as base behavior has changed recently
    x <- factor(letters[1:4], levels = letters[1:10])
    variable_label(x) <- "Test me!"
    x <- droplevels(x, exclude = "d")

    y <- factor(letters[1:4], levels = letters[1:10])
    y <- droplevels(y, exclude = "d")
    variable_label(y) <- "Test me!"

    expect_identical(
      object = x
      , expected = y
    )
  }
)

test_that(
  "[.tiny_labelled-method, [[.tiny_labelled-method"
  , {
    x <- factor(letters[1:4], levels = letters[1:10])
    variable_label(x) <- "Test me!"
    y <- x[1:3]
    z <- x[[2]]

    expect_identical(
      object = y
      , expected = structure(
        1:3
        , .Label = letters[1:10]
        , class = c("tiny_labelled", "factor")
        , label = "Test me!"
      )
    )

    expect_identical(
      object = z
      , expected = structure(
        2L
        , .Label = letters[1:10]
        , class = c("tiny_labelled", "factor")
        , label = "Test me!"
      )
    )

    expect_identical(variable_label(y), "Test me!")
    expect_identical(class(y), c("tiny_labelled", "factor"))
    expect_identical(levels(y), letters[1:10])
  }
)



test_that(
  "rep.tiny_labelled-method"
  , {
    o1 <- 1:3
    variable_label(o1) <- "Test me!"
    o1 <- rep(o1, 2)
    o2 <- rep(1:3, 2)
    variable_label(o2) <- "Test me!"

    expect_identical(
      object = o1
      , expected = o2
    )
  }
)



test_that(
  "print.tiny_labelled-method"
  , {
    labelled_vector <- 1:4
    variable_label(labelled_vector) <- "Test label"
    print_with_label <- capture_output(print(labelled_vector))
    # + unit
    attr(labelled_vector, "unit") <- "cm"
    print_with_unit <- capture_output(print(labelled_vector))

    expect_identical(
      print_with_label
      , expected = "Variable label     : Test label\n[1] 1 2 3 4"
    )
    expect_identical(
      print_with_unit
      , expected = "Variable label     : Test label\nUnit of measurement: cm\n[1] 1 2 3 4"
    )
  }
)
