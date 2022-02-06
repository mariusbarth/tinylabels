
# tinylabels 0.2.3

- Added `as()` methods to support the S4 class system.
- For the data-frame method, if names of to-be-assigned values (i.e., keys) are
  duplicated, an informative error message is returned.
- Added vignette specifying desired behavior of the `tiny_labelled` class.

# tinylabels 0.2.2

- Added methods for group generics `Math`, `Ops`, `Summary`, and `Complex` from
  the **base** package.

# tinylabels 0.2.1

- Removed `LazyData` from DESCRIPTION file

# tinylabels 0.2.0

- Added a `NEWS.md` file to track changes to the package.
- Input validation now ensures that variable labels are (1) atomic vectors (i.e.,
  no list-like objects) of (2) length equal to zero or one that (3) are not NULL.
- In `variable.data.frame()<-`, NULL elements of a value list are now ignored,
  which simplifies extracting variable labels from one data frame and assigning
  these variable labels to the corresponding columns of another data frame.
- In `assign_label.default()`, label and class attribute are now directly set,
  which comes with a small performance benefit.
