
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
    z <- x[[2, keep_label = TRUE]]
    zz <- x[[2]]

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
    expect_identical(
      object = zz
      , expected = structure(
        2L
        , .Label = letters[1:10]
        , class = "factor"
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

test_that(
  "Coercion of tiny_labelled"
  , {
    labelled_vector <- 0:4
    variable_label(labelled_vector) <- "Test label"

    # as.logical() ----
    expect_identical(
      as.logical(labelled_vector)
      , structure(
        as.logical(0:4)
        , label = "Test label"
        , class = c("tiny_labelled", "logical")
      )
    )
    expect_identical(
      as.logical(labelled_vector, keep_label = FALSE)
      , as.logical(0:4)
    )

    # as.integer() ----
    expect_identical(
      as.integer(labelled_vector)
      , labelled_vector
    )
    expect_identical(
      as.integer(labelled_vector, keep_label = FALSE)
      , 0:4
    )

    # as.double() ----
    expect_identical(
      as.double(labelled_vector)
      , structure(
        as.double(0:4)
        , label = "Test label"
        , class = c("tiny_labelled", "numeric")
      )
    )
    expect_identical(
      as.double(labelled_vector, keep_label = FALSE)
      , as.double(0:4)
    )

    # as.numeric() ----
    expect_identical(
      as.numeric(labelled_vector)
      , as.double(labelled_vector)
    )
    expect_identical(
      as.numeric(labelled_vector, keep_label = FALSE)
      , as.double(labelled_vector, keep_label = FALSE)
    )

    # as.complex() ----
    expect_identical(
      as.complex(labelled_vector)
      , structure(
        as.complex(0:4)
        , label = "Test label"
        , class = c("tiny_labelled", "complex")
      )
    )
    expect_identical(
      as.complex(labelled_vector, keep_label = FALSE)
      , as.complex(0:4)
    )


    # as.character() ----
    expect_identical(
      as.character(labelled_vector)
      , structure(
        as.character(0:4)
        , label = "Test label"
        , class = c("tiny_labelled", "character")
      )
    )
    expect_identical(
      as.character(labelled_vector, keep_label = FALSE)
      , as.character(0:4)
    )
  }
)

test_that(
  "Arithmetic group generics"
  , {
    labelled_vector <- -1:4
    variable_label(labelled_vector) <- "An integer vector"

    # Math (x, ...)
    expect_identical(
      abs(labelled_vector)
      , expected = abs(-1:4)
    )
    # Ops (e1, e2)
    expect_identical(
      labelled_vector/2
      , expected = -1:4 / 2 # numeric!
    )
    # Ops (e1)
    expect_identical(
      -labelled_vector
      , expected = 1:-4
    )
    # Summary(..., na.rm = FALSE)
    expect_identical(
      min(labelled_vector)
      , -1L
    )
    # Complex(z)
    labelled_complex <- as.complex(1:4)
    variable_label(labelled_complex) <- "A complex-valued vector"
    expect_identical(
      Im(labelled_complex)
      , expected = rep(0, 4)
    )

  }
)
