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





