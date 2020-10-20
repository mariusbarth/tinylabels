.onLoad <- function(...) {

  if(requireNamespace("vctrs", quietly = TRUE)) {
    s3_register("vctrs::vec_ptype2", "papaja_labelled.papaja_labelled")

    s3_register("vctrs::vec_ptype2", "papaja_labelled.logical")
    s3_register("vctrs::vec_ptype2", "papaja_labelled.integer")
    s3_register("vctrs::vec_ptype2", "papaja_labelled.double")
    s3_register("vctrs::vec_ptype2", "papaja_labelled.complex")
    s3_register("vctrs::vec_ptype2", "papaja_labelled.raw")
    s3_register("vctrs::vec_ptype2", "papaja_labelled.character")
    s3_register("vctrs::vec_ptype2", "papaja_labelled.factor")
    s3_register("vctrs::vec_ptype2", "papaja_labelled.ordered")


    s3_register("vctrs::vec_ptype2", "logical.papaja_labelled")
    s3_register("vctrs::vec_ptype2", "integer.papaja_labelled")
    s3_register("vctrs::vec_ptype2", "double.papaja_labelled")
    s3_register("vctrs::vec_ptype2", "complex.papaja_labelled")
    s3_register("vctrs::vec_ptype2", "raw.papaja_labelled")
    s3_register("vctrs::vec_ptype2", "character.papaja_labelled")
    s3_register("vctrs::vec_ptype2", "factor.papaja_labelled")
    s3_register("vctrs::vec_ptype2", "ordered.papaja_labelled")

    s3_register("vctrs::vec_cast", "papaja_labelled.papaja_labelled")

    s3_register("vctrs::vec_cast", "papaja_labelled.logical")
    s3_register("vctrs::vec_cast", "papaja_labelled.integer")
    s3_register("vctrs::vec_cast", "papaja_labelled.double")
    s3_register("vctrs::vec_cast", "papaja_labelled.complex")
    s3_register("vctrs::vec_cast", "papaja_labelled.raw")
    s3_register("vctrs::vec_cast", "papaja_labelled.character")
    s3_register("vctrs::vec_cast", "papaja_labelled.factor")
    s3_register("vctrs::vec_cast", "papaja_labelled.ordered")

    s3_register("vctrs::vec_cast", "logical.papaja_labelled")
    s3_register("vctrs::vec_cast", "integer.papaja_labelled")
    s3_register("vctrs::vec_cast", "double.papaja_labelled")
    s3_register("vctrs::vec_cast", "complex.papaja_labelled")
    s3_register("vctrs::vec_cast", "raw.papaja_labelled")
    s3_register("vctrs::vec_cast", "character.papaja_labelled")
    s3_register("vctrs::vec_cast", "factor.papaja_labelled")
    s3_register("vctrs::vec_cast", "ordered.papaja_labelled")
  }

  invisible()
}


# from the vctrs package:
#' @keywords internal

s3_register <- function(generic, class, method = NULL) {
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)

  pieces <- strsplit(generic, "::")[[1]]
  stopifnot(length(pieces) == 2)
  package <- pieces[[1]]
  generic <- pieces[[2]]

  caller <- parent.frame()

  get_method_env <- function() {
    top <- topenv(caller)
    if (isNamespace(top)) {
      asNamespace(environmentName(top))
    } else {
      caller
    }
  }
  get_method <- function(method, env) {
    if (is.null(method)) {
      get(paste0(generic, ".", class), envir = get_method_env())
    } else {
      method
    }
  }

  method_fn <- get_method(method)
  stopifnot(is.function(method_fn))

  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(package, "onLoad"),
    function(...) {
      ns <- asNamespace(package)

      # Refresh the method, it might have been updated by `devtools::load_all()`
      method_fn <- get_method(method)

      registerS3method(generic, class, method_fn, envir = ns)
    }
  )

  # Avoid registration failures during loading (pkgload or regular)
  if (!isNamespaceLoaded(package)) {
    return(invisible())
  }

  envir <- asNamespace(package)

  # Only register if generic can be accessed
  if (exists(generic, envir)) {
    registerS3method(generic, class, method_fn, envir = envir)
  }

  invisible()
}
