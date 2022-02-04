context("variable_label() replacement methods")

test_that(
  "variable_label<-.default"
  , {
    object <- 1:4
    variable_label(object) <- "Label 1"

    expect_identical(
      object = object
      , expected = structure(
        1:4
        , label = "Label 1"
        , class = c("tiny_labelled", "integer")
      )
    )

    expect_error(
      variable_label(object) <- NULL
      , regexp = "Variable labels must not be NULL. To entirely remove variable labels, use unlabel()."
    )
    expect_error(
      variable_label(object) <- 1:2
      , regexp = "Trying to set a variable label of length greater than one: '1', '2'"
    )

    # Recursively use unlist() on list-like input
    variable_label(object) <- list(b = list("a"))
    expect_identical(
      variable_label(object)
      , "a"
    )
  }
)

test_that(
  "variable_label<-.data.frame"
  , {
    object <- data.frame(a = 1:4, b = 5:8)
    object$c <- list(1:2, 3:4, 5:6, 7:8) # add a list column

    expect_error(
      variable_label(object) <- c("not_in_data" = "test")
      , "While trying to set variable labels, some requested columns could not be found in data.frame:\n'not_in_data'"
      , fixed = TRUE
    )
    expect_error(
      variable_label(object) <- "a"
      , "The assigned variable label(s) must be passed as a named vector or a named list."
      , fixed = TRUE
    )
    variable_label(object) <- c("a" = "A beautiful test label.", c = "Deal with list columns")

    expect_identical(
      object = object
      , expected = structure(
        list(
          a = structure(
            1:4
            , label = "A beautiful test label."
            , class = c("tiny_labelled", "integer")
          )
          , b = 5:8
          , c = structure(
            list(1:2, 3:4, 5:6, 7:8)
            , label = "Deal with list columns"
            , class = c("tiny_labelled", "list")
          )
        )
        , row.names = c(NA, -4L)
        , class = "data.frame"
      )
    )

    object <- label_variables(
      object
      , a = "A different, but equally beautiful, test label."
      , b = "A mediocre reinterpretation of the a's label."
    )

    expect_identical(
      object = object
      , expected = structure(
        list(
          a = structure(
            1:4
            , label = "A different, but equally beautiful, test label."
            , class = c("tiny_labelled", "integer")
          )
          , b = structure(
            5:8
            , label = "A mediocre reinterpretation of the a's label."
            , class = c("tiny_labelled", "integer")
          )
          , c = structure(
            list(1:2, 3:4, 5:6, 7:8)
            , label = "Deal with list columns"
            , class = c("tiny_labelled", "list")
          )
        )
        , row.names = c(NA, -4L)
        , class = "data.frame"
      )
    )

    object <- npk
    variable_label(object) <- c(
      N = "Nitrogen"
      , P = NULL
    )
  }
)

test_that(
  "variable_label.data.frame() for duplicate column names"
  , {
    object <- data.frame(x = 1, x = 2, check.names = F)
    variable_label(object) <- c(x = "Test duplicate columns")
    expect_identical(
      variable_label(object)
      , list(x = "Test duplicate columns", x = "Test duplicate columns")
    )
  }
)

test_that(
  "variable_label.data.frame() -- only modify columns if value is not NULL"
  , {
    object <- data.frame(
      x = 1
      , y = 2
    )
    variable_labels(object) <- list(
      x = "A nice label"
      , y = NULL
    )

    expect_identical(
      variable_labels(object)
      , list(x = "A nice label", y = NULL)
    )

  }
)



context("variable_label() extraction methods")

test_that(
  "variable_label.tiny_labelled-method"
  , {
    object <- 1:10
    class(object) <- c("tiny_labelled", "integer")
    attr(object, "label") <- "label1"

    expect_identical(
      object = variable_label(object)
      , expected = "label1"
    )
  }
)

test_that(
  "variable_label.data.frame-method"
  , {
    x <- npk
    variable_label(x) <- list(N = "Nitrogen", P = "Phosphate", K = expression(italic(K)))

    expect_identical(
      variable_label(x)
      , list(
        block   = NULL
        , N     = "Nitrogen"
        , P     = "Phosphate"
        , K     = expression(italic(K))
        , yield = NULL
      )
    )
    expect_error(
      variable_label(x) <- list(N = "a", N = "b")
      , "Duplicated names for 'value'."
      , fixed = TRUE
    )
  }
)
