#' Reorder Levels of Labelled Factor
#'
#' The levels of a factor are re-ordered so that the level specified by ref is
#' first and the others are moved down. This is a copy from \code{\link[stats]{relevel}}
#' in the \pkg{stats} package, but preserves the \code{label} attribute and class \code{tiny_labelled}.
#' @importFrom stats relevel
#' @inheritParams stats::relevel
#' @export

relevel.papaja_labelled <- function(x, ref, ...){
  y <- NextMethod()
  variable_label(y) <- variable_label(x)
  y
}
