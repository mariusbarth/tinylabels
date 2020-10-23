
context("methods for generics from vctrs (i.e., tidyverse support)")

test_that(
  "methods for vec_ptype2() and vec_cast()"
  , {
    library(vctrs)
    obj1 <- obj2 <- obj3 <- 1:4
    variable_label(obj1) <- "a"
    variable_label(obj2) <- "b"

    combined_prototype <- integer(0L)
    variable_label(combined_prototype) <- c("a")

    labelled_integer <- integer(0L)
    labelled_double  <- double(0L)
    labelled_complex <- complex(0L)
    variable_label(labelled_integer) <- "a"
    variable_label(labelled_double)  <- "a"
    variable_label(labelled_complex) <- "a"

    # Both labelled:
    expect_warning(
      expect_identical(vec_ptype2(obj1, obj2), combined_prototype) # "a"
      , regexp = "While combining two labelled vectors, variable label 'b' was dropped and variable label 'a' was retained."
    )
    expect_identical(vec_ptype2(obj1, obj1), labelled_integer)   # "a"

    expect_identical(vec_ptype2(obj1, TRUE), labelled_integer)
    expect_identical(vec_ptype2(TRUE, obj1), labelled_integer)
    expect_identical(vec_ptype2(obj1, 1L), labelled_integer)
    expect_identical(vec_ptype2(obj1, 1.4), labelled_double)
    expect_identical(vec_ptype2(obj1, complex(1)), labelled_complex)

    expect_identical(vec_ptype2(logical(1), obj1), labelled_integer)
    expect_identical(vec_ptype2(integer(1), obj1), labelled_integer)
    expect_identical(vec_ptype2(double(1) , obj1), labelled_double)
    expect_identical(vec_ptype2(complex(1), obj1), labelled_complex)

    # logical to labelled
    expect_identical(
      vec_cast(x = TRUE, vec_ptype2(obj1, TRUE))
      , obj1[1]
    )
    # labelled to same labelled
    expect_identical(
      vec_cast(x = obj1, obj1[FALSE])
      , obj1
    )

    # labelled to other labelled
    expect_warning(
      expect_identical(
        vec_cast(x = obj1, vec_ptype2(obj2, obj1))
        , obj2
      )
      , regexp = "While combining two labelled vectors, variable label 'a' was dropped and variable label 'b' was retained."
    )

    # labelled to logical
    expect_identical(
      vec_cast(obj1, double(0L))
      , as.double(1:4)
    )
  }
)

test_that(
  "vctrs in action"
  , {

    variable_label(npk) <- c(N = "Nitrogen")
    expected <- rep(npk$N, 3L)

    expect_identical(
      vctrs::vec_rep(npk$N, 3L)
      , expected
    )
  }
)
