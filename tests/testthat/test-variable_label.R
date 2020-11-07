context("variable_label() replacement methods")

test_that(
  "variable_label<-.default"
  , {
    object_1 <- 1:4
    variable_label(object_1) <- "label_1"

    expect_identical(
      object = object_1
      , expected = structure(
        1:4
        , label = "label_1"
        , class = c("tiny_labelled", "integer")
      )
    )

    test2 <- test <- letters[1:3]

    # Setting only a NULL label does not yet add class tiny_labelled
    variable_label(test) <- NULL

    expect_identical(
      test
      , test2
    )

    # But overwriting a label with NULL does not remove the class
    variable_label(test) <- "a"
    variable_label(test) <- NULL
    expect_identical(
      test
      , structure(
        letters[1:3]
        , label = NULL
        , class = c("tiny_labelled", "character")
      )
    )
    variable_label(test)

    expect_error(
      variable_label(test) <- 1:2
      , regexp = "Trying to set a variable label of length greater than one: 1, 2"
    )
    variable_label(test) <- list(b = "a")
    expect_identical(
      variable_label(test)
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
      , "The assigned variable label(s) must be passed as a named vector or list."
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
  variable_label(object)

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
  }
)





