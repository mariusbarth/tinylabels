
# These methods are dynamically registered (code in file onload.R) if the
# vctrs package is available.

# vec_ptype2() -----------------------------------------------------------------

vec_ptype2.tiny_labelled.tiny_labelled <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  z <- vctrs::vec_ptype2(x = unlabel(x), y = unlabel(y), ..., x_arg = x_arg, y_arg = y_arg)
  if(!identical(variable_label(x), variable_label(y))) {
    warning(
      "While combining two labelled vectors, variable label '"
      , encodeString(variable_label(y))
      , "' was dropped and variable label '"
      , encodeString(variable_label(x))
      , "' was retained."
      # , call. = FALSE
    )
  }
  variable_label(z) <- variable_label(x)
  z
}



vec_ptype2.tiny_labelled.logical <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  z <- vctrs::vec_ptype2(x = unlabel(x), y = y, ..., x_arg = x_arg, y_arg = y_arg)
  variable_label(z) <- variable_label(x)
  z
}

vec_ptype2.tiny_labelled.integer   <- vec_ptype2.tiny_labelled.logical
vec_ptype2.tiny_labelled.double    <- vec_ptype2.tiny_labelled.logical
vec_ptype2.tiny_labelled.complex   <- vec_ptype2.tiny_labelled.logical
vec_ptype2.tiny_labelled.raw       <- vec_ptype2.tiny_labelled.logical
vec_ptype2.tiny_labelled.character <- vec_ptype2.tiny_labelled.logical
vec_ptype2.tiny_labelled.factor    <- vec_ptype2.tiny_labelled.logical
vec_ptype2.tiny_labelled.ordered   <- vec_ptype2.tiny_labelled.logical



vec_ptype2.logical.tiny_labelled <- function(
  x, y, ..., x_arg = "", y_arg = ""
) {
  z <- vctrs::vec_ptype2(x = x, y = unlabel(y), ..., x_arg = x_arg, y_arg = y_arg)
  variable_label(z) <- variable_label(y)
  z
}

vec_ptype2.integer.tiny_labelled   <- vec_ptype2.logical.tiny_labelled
vec_ptype2.double.tiny_labelled    <- vec_ptype2.logical.tiny_labelled
vec_ptype2.complex.tiny_labelled   <- vec_ptype2.logical.tiny_labelled
vec_ptype2.raw.tiny_labelled       <- vec_ptype2.logical.tiny_labelled
vec_ptype2.character.tiny_labelled <- vec_ptype2.logical.tiny_labelled
vec_ptype2.factor.tiny_labelled    <- vec_ptype2.logical.tiny_labelled
vec_ptype2.ordered.tiny_labelled   <- vec_ptype2.logical.tiny_labelled



# vec_cast() -------------------------------------------------------------------

vec_cast.tiny_labelled.tiny_labelled <- function(x, to, ...) {
  y <- vctrs::vec_cast(x = x, to = unlabel(to), ...)
  variable_label(y) <- variable_label(to)
  y
}



vec_cast.tiny_labelled.logical <- function(x, to, ...) {
  y <- vctrs::vec_cast(x = x, to = unlabel(to), ...)
  variable_label(y) <- variable_label(to)
  y
}

vec_cast.tiny_labelled.integer    <- vec_cast.tiny_labelled.logical
vec_cast.tiny_labelled.double     <- vec_cast.tiny_labelled.logical
vec_cast.tiny_labelled.raw        <- vec_cast.tiny_labelled.logical
vec_cast.tiny_labelled.complex    <- vec_cast.tiny_labelled.logical
vec_cast.tiny_labelled.character  <- vec_cast.tiny_labelled.logical
vec_cast.tiny_labelled.factor     <- vec_cast.tiny_labelled.logical
vec_cast.tiny_labelled.ordered    <- vec_cast.tiny_labelled.logical



vec_cast.logical.tiny_labelled <- function(x, to, ...) {
  vctrs::vec_cast(x = unlabel(x), to = to, ...)
}

vec_cast.integer.tiny_labelled    <- vec_cast.logical.tiny_labelled
vec_cast.double.tiny_labelled     <- vec_cast.logical.tiny_labelled
vec_cast.raw.tiny_labelled        <- vec_cast.logical.tiny_labelled
vec_cast.complex.tiny_labelled    <- vec_cast.logical.tiny_labelled
vec_cast.character.tiny_labelled  <- vec_cast.logical.tiny_labelled
vec_cast.factor.tiny_labelled     <- vec_cast.logical.tiny_labelled
vec_cast.ordered.tiny_labelled    <- vec_cast.logical.tiny_labelled
