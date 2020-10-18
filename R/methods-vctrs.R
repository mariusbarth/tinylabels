
# These methods are dynamically registered if the vctrs package is available

vec_ptype2.papaja_labelled.papaja_labelled <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  warning("Variable labels were dropped because 'vec_ptype2()' was called internally.", call. = FALSE)
  vctrs::vec_ptype2(x = unlabel(x), y = unlabel(y), ..., x_arg = x_arg, y_arg = y_arg)
}

vec_ptype2.papaja_labelled.logical <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  warning("Variable labels were dropped because 'vec_ptype2()' was called internally.", call. = FALSE)
  vctrs::vec_ptype2(x = unlabel(x), y = y, ..., x_arg = x_arg, y_arg = y_arg)
}


vec_ptype2.papaja_labelled.integer <- vec_ptype2.papaja_labelled.logical


vec_ptype2.papaja_labelled.double <- vec_ptype2.papaja_labelled.logical


vec_ptype2.papaja_labelled.complex <- vec_ptype2.papaja_labelled.logical


vec_ptype2.papaja_labelled.raw <- vec_ptype2.papaja_labelled.logical


vec_ptype2.papaja_labelled.character <- vec_ptype2.papaja_labelled.logical




vec_ptype2.logical.papaja_labelled <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  warning("Variable labels were dropped because 'vec_ptype2()' was called internally.", call. = FALSE)
  vctrs::vec_ptype2(x = x, y = unlabel(y), ..., x_arg = x_arg, y_arg = y_arg)
}


vec_ptype2.integer.papaja_labelled <- vec_ptype2.logical.papaja_labelled


vec_ptype2.double.papaja_labelled <- vec_ptype2.logical.papaja_labelled


vec_ptype2.complex.papaja_labelled <- vec_ptype2.logical.papaja_labelled


vec_ptype2.raw.papaja_labelled <- vec_ptype2.logical.papaja_labelled

vec_ptype2.character.papaja_labelled <- vec_ptype2.logical.papaja_labelled
