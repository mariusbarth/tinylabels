
methods::setClass(
  Class = "tiny_labelled"
  , contains = "vector"
)

methods::setAs(
  from = "tiny_labelled"
  , to = "numeric"
  , def = function(from) {
    as(unlabel(from), "numeric")
  }
)

methods::setAs(
  from = "tiny_labelled"
  , to = "integer"
  , def = function(from) {
    as(unlabel(from), "integer")
  }
)


