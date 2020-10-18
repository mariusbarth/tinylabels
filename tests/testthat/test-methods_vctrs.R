test_that(
  "Methods for vctrs package"
  , {
    library(vctrs)
    obj1 <- obj2 <- obj3 <- 1:4
    variable_label(obj1) <- "a"
    variable_label(obj2) <- "b"

    # Both labelled:
    expect_identical(vec_ptype2(obj1, obj2), integer(0))

    expect_identical(vec_ptype2(obj1, TRUE), integer(0))
    expect_identical(vec_ptype2(obj1, 1L), integer(0))
    expect_identical(vec_ptype2(obj1, 1.4), double(0))
    expect_identical(vec_ptype2(obj1, complex(1)), complex(0))

    expect_identical(vec_ptype2(logical(1), obj1), integer(0))
    expect_identical(vec_ptype2(integer(1), obj1), integer(0))
    expect_identical(vec_ptype2(double(1) , obj1), double(0))
    expect_identical(vec_ptype2(complex(1), obj1), complex(0))
  }
)
