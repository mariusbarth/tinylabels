# tinylabels 0.1.0.9000

- Input validation now ensures that variable labels are always atomic vectors of length zero or one.
- Trying to set a variable label that is `NULL` now only sets the label attribute to `NULL`, without changing the class of `x`.
- Performance improvements to `assign_label.default()`.
- Added a `NEWS.md` file to track changes to the package.
