


#' @keywords internal

assign_label <- function(x, value, ...){
  UseMethod("assign_label")
}



#' @keywords internal

assign_label.default <- function(x, value){

  if(missing(value) || is.null(value)) stop("Parameter 'value' must not be NULL.")

  structure(
    x
    , label = value
    , class = c("tiny_labelled", setdiff(class(x), "tiny_labelled"))
  )
}



#' @keywords internal

assign_label.data.frame <- function(x, value, ...){

  # R allows data frames to have duplicate column names.
  # The following code is optimized to work even in this horrible case.
  # This is especially important for default_label and apa_table (e.g., in
  # a frequency table, you frequently have repeating column names):

  if(is.null(names(value))){
    stop(
      "The assigned variable label(s) must be passed as a named vector or list."
      , call. = FALSE
    )
  }

  if(!all(names(value) %in% colnames(x))){
    stop(
      "While trying to set variable labels, some requested columns could not be found in data.frame:\n"
      , paste(encodeString(setdiff(names(value), colnames(x)), quote = "'"), collapse = ", ")
      , call. = FALSE
    )
  }

  for(i in seq_along(colnames(x))) {
    if(any(colnames(x)[i] == names(value))) {
      x[[i]] <- assign_label(x[[i]], value[[colnames(x)[i]]])
    }
  }

  x
}
