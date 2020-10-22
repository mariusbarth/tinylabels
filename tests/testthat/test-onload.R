context("onload")

test_that(
  "Register S3 methods if vctrs package available"
  , {
    tinylabels:::.onLoad()
    library(vctrs)
    vec_ptype2_methods <- as.character(methods("vec_ptype2"))
    vec_cast_methods   <- as.character(methods("vec_cast"))

    expected_support <- c(
      "tiny_labelled" # self-self
      , "logical"
      , "integer"
      , "double"
      , "complex"
      , "raw"
      , "character"
      , "factor"
      , "ordered"
    )

    expect(
      all(
        paste0("vec_ptype2.tiny_labelled.", expected_support) %in% vec_ptype2_methods
      )
      , failure_message = "Not all vec_ptype2()-methods available."
    )
    expect(
      all(
        paste0("vec_ptype2.", expected_support, ".tiny_labelled") %in% vec_ptype2_methods
      )
      , failure_message = "Not all vec_ptype2()-methods available."
    )
    expect(
      all(
        paste0("vec_cast.tiny_labelled.", expected_support) %in% vec_cast_methods
      )
      , failure_message = "Not all vec_cast()-methods available."
    )
    expect(
      all(
        paste0("vec_cast.", expected_support, ".tiny_labelled") %in% vec_cast_methods
      )
      , failure_message = "Not all vec_cast()-methods available."
    )
  }
)
