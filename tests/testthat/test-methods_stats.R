
context("methods for generics from stats")

test_that(
  "relevel.tiny_labelled-method"
  , {
    o1 <- factor(letters[1:3], levels = letters[1:3])
    variable_label(o1) <- "Test me!"
    o1 <- relevel(o1, "b")

    expect_identical(
      object = o1
      , expected = structure(c(2L, 1L, 3L), .Label = c("b", "a", "c"), class = c("tiny_labelled", "factor"), label = "Test me!")
    )
    # Check all attributes separately, as sometimes expect_identical seems to be sloppy
    expect_identical(variable_label(o1), expected = "Test me!")
    expect_identical(levels(o1), expected = c("b", "a", "c"))
    expect_identical(class(o1), expected = c("tiny_labelled", "factor"))
  }
)
