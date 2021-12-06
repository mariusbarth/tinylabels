

#' @export

`[.tiny_labelled` <- function(x, ..., drop = FALSE) {
  y <- NextMethod("[")
  variable_label(y) <- variable_label(x)
  y
}



#' @export

`[[.tiny_labelled` <- function(x, ..., exact = TRUE) {
  y <- NextMethod("[[")
  variable_label(y) <- variable_label(x)
  y
}



#' @export

print.tiny_labelled <- function(x, ...) {
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

droplevels.tiny_labelled <- function(x, exclude = if(anyNA(levels(x))) NULL else NA, ...){
  y <- NextMethod("droplevels", x, exclude = exclude, ...)
  variable_label(y) <- variable_label(x)
  y
}



#' @export

rep.tiny_labelled <- function(x, ...){
  y <- NextMethod()
  variable_label(y) <- variable_label(x)
  y
}




#' Conversion of Labelled Vectors
#'
#' Functions to convert labelled vectors to other types, possibly keeping the variable
#' label and the class attribute `tiny_labelled`.
#'
#' @param x          Object to be coerced
#' @param keep_label Logical indicating whether the variable labels and class `tiny_labelled` should be kept.
#' @param ...        Further arguments passed to methods
#'
#' @rdname coerce-tiny_labelled
#' @method as.character tiny_labelled
#' @export

as.character.tiny_labelled <- function(x, keep_label = TRUE, ...) {
  y <- NextMethod("as.character", x, ...)
  if (keep_label) variable_label(y) <- variable_label(x)
  y
}


#' @rdname coerce-tiny_labelled
#' @method as.logical tiny_labelled
#' @export

as.logical.tiny_labelled <- function(x, keep_label = TRUE, ...) {
  y <- NextMethod("as.logical", x, ...)
  if (keep_label) variable_label(y) <- variable_label(x)
  y
}

#' @rdname coerce-tiny_labelled
#' @method as.integer tiny_labelled
#' @export

as.integer.tiny_labelled <- function(x, keep_label = TRUE, ...) {
  y <- NextMethod("as.integer", x, ...)
  if (keep_label) variable_label(y) <- variable_label(x)
  y
}

#' @rdname coerce-tiny_labelled
#' @method as.double tiny_labelled
#' @export

as.double.tiny_labelled <- function(x, keep_label = TRUE, ...) {
  y <- NextMethod("as.double", x, ...)
  if (keep_label) variable_label(y) <- variable_label(x)
  y
}

#' @rdname coerce-tiny_labelled
#' @method as.complex tiny_labelled
#' @export

as.complex.tiny_labelled <- function(x, keep_label = TRUE, ...) {
  y <- NextMethod("as.complex", x, ...)
  if (keep_label) variable_label(y) <- variable_label(x)
  y
}

#' @method Math tiny_labelled
#' @export

Math.tiny_labelled <- function(x) {
  eval(call(name = .Generic, unlabel(x)))
}

#' @method Ops tiny_labelled
#' @export

Ops.tiny_labelled <- function(e1, e2) {
  if(missing(e2)) return(eval(call(.Generic, unlabel(e1))))
  eval(call(.Generic, e1 = unlabel(e1), e2 = unlabel(e2)))
}

#' @method Summary tiny_labelled
#' @export

Summary.tiny_labelled <- function(x, ..., na.rm = FALSE) {
  do.call(.Generic, list(x = unlabel(x), ..., na.rm = na.rm))
}


#' @method Complex tiny_labelled
#' @export

Complex.tiny_labelled <- function(z) {
  eval(call(.Generic, unlabel(z)))
}
