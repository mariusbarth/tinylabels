

#' @export

`[.papaja_labelled` <- function(x, ..., drop = FALSE) {
  y <- NextMethod("[")
  variable_label(y) <- variable_label(x)
  y
}



#' @export

`[[.papaja_labelled` <- function(x, ..., exact = TRUE) {
  y <- NextMethod("[[")
  variable_label(y) <- variable_label(x)
  y
}



#' @export

print.papaja_labelled <- function(x, ...) {
  unit_defined <- !is.null(attr(x, "unit"))

  cat(
    "Variable label     : ", encodeString(attr(x, "label"))
    , if(unit_defined) {"\nUnit of measurement: "}
    , if(unit_defined) {encodeString(attr(x, "unit"))}
    , "\n"
    , sep = ""
  )
  x <- unlabel(x)
  NextMethod("print")
}



#' @export

droplevels.papaja_labelled <- function(x, exclude = if(anyNA(levels(x))) NULL else NA, ...){
  y <- NextMethod("droplevels", x, exclude = exclude, ...)
  variable_label(y) <- variable_label(x)
  y
}



#' @export

rep.papaja_labelled <- function(x, ...){
  y <- NextMethod()
  variable_label(y) <- variable_label(x)
  y
}



#' Conversion of Labelled Vectors
#'
#' Functions to convert labelled vectors to other representations.
#'
#' @param x          Object to be coerced
#' @param keep_label Logical indicating whether the variable labels should be kept.
#' @param ...        Further arguments passed to or from methods
#' @method as.character papaja_labelled
#' @export

as.character.papaja_labelled <- function(x, keep_label = TRUE, ...) {
  y <- NextMethod("as.character", x, ...)
  if (keep_label) variable_label(y) <- variable_label(x)
  y
}
