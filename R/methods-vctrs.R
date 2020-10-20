
# These methods are dynamically registered (code in file onload.R) if the
# vctrs package is available.

# vec_ptype2() -----------------------------------------------------------------

vec_ptype2.papaja_labelled.papaja_labelled <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  z <- vctrs::vec_ptype2(x = unlabel(x), y = unlabel(y), ..., x_arg = x_arg, y_arg = y_arg)
  variable_label(z) <- unique(c(variable_label(x), variable_label(y)))
  z
}



vec_ptype2.papaja_labelled.logical <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  z <- vctrs::vec_ptype2(x = unlabel(x), y = y, ..., x_arg = x_arg, y_arg = y_arg)
  variable_label(z) <- variable_label(x)
  z
}

vec_ptype2.papaja_labelled.integer <- vec_ptype2.papaja_labelled.logical
vec_ptype2.papaja_labelled.double <- vec_ptype2.papaja_labelled.logical
vec_ptype2.papaja_labelled.complex <- vec_ptype2.papaja_labelled.logical
vec_ptype2.papaja_labelled.raw <- vec_ptype2.papaja_labelled.logical
vec_ptype2.papaja_labelled.character <- vec_ptype2.papaja_labelled.logical
vec_ptype2.papaja_labelled.factor <- vec_ptype2.papaja_labelled.logical
vec_ptype2.papaja_labelled.ordered <- vec_ptype2.papaja_labelled.logical



vec_ptype2.logical.papaja_labelled <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  # warning("Variable labels were dropped because 'vec_ptype2()' was called internally.", call. = FALSE)
  z <- vctrs::vec_ptype2(x = x, y = unlabel(y), ..., x_arg = x_arg, y_arg = y_arg)
  variable_label(z) <- variable_label(y)
  z
}

vec_ptype2.integer.papaja_labelled   <- vec_ptype2.logical.papaja_labelled
vec_ptype2.double.papaja_labelled    <- vec_ptype2.logical.papaja_labelled
vec_ptype2.complex.papaja_labelled   <- vec_ptype2.logical.papaja_labelled
vec_ptype2.raw.papaja_labelled       <- vec_ptype2.logical.papaja_labelled
vec_ptype2.character.papaja_labelled <- vec_ptype2.logical.papaja_labelled
vec_ptype2.factor.papaja_labelled    <- vec_ptype2.logical.papaja_labelled
vec_ptype2.ordered.papaja_labelled   <- vec_ptype2.logical.papaja_labelled



# vec_cast() -------------------------------------------------------------------

vec_cast.papaja_labelled.papaja_labelled <- function(x, to, ...) {
  y <- vctrs::vec_cast(x = x, to = unlabel(to), ...)
  variable_label(y) <- variable_label(to)
  y
}



vec_cast.papaja_labelled.logical <- function(x, to, ...) {
  y <- vctrs::vec_cast(x = x, to = unlabel(to), ...)
  variable_label(y) <- variable_label(to)
  y
}

vec_cast.papaja_labelled.integer    <- vec_cast.papaja_labelled.logical
vec_cast.papaja_labelled.double     <- vec_cast.papaja_labelled.logical
vec_cast.papaja_labelled.raw        <- vec_cast.papaja_labelled.logical
vec_cast.papaja_labelled.complex    <- vec_cast.papaja_labelled.logical
vec_cast.papaja_labelled.character  <- vec_cast.papaja_labelled.logical
vec_cast.papaja_labelled.factor     <- vec_cast.papaja_labelled.logical
vec_cast.papaja_labelled.ordered    <- vec_cast.papaja_labelled.logical



vec_cast.logical.papaja_labelled <- function(x, to, ...) {
  vctrs::vec_cast(x = unlabel(x), to = to, ...)
}

vec_cast.integer.papaja_labelled    <- vec_cast.logical.papaja_labelled
vec_cast.double.papaja_labelled     <- vec_cast.logical.papaja_labelled
vec_cast.raw.papaja_labelled        <- vec_cast.logical.papaja_labelled
vec_cast.complex.papaja_labelled    <- vec_cast.logical.papaja_labelled
vec_cast.character.papaja_labelled  <- vec_cast.logical.papaja_labelled
vec_cast.factor.papaja_labelled     <- vec_cast.logical.papaja_labelled
vec_cast.ordered.papaja_labelled    <- vec_cast.logical.papaja_labelled
