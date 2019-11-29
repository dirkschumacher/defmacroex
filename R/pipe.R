#' @include macros.R
some_constant <- constexpr(qnorm(0.975))

#' Analyze a dataset
#'
#' @param data the dataset
#'
#' @export
#' @include macros.R
analyze_dataset <- function(data) {
  log("Computing result")
  assert("is a data frame", stopifnot(is.data.frame(data)))
  assert("has right columns", stopifnot(c("hp", "cyl") %in% colnames(data)))
  result <- data %>%
    dplyr::filter(hp > constexpr(50 + 50 + qnorm(0.975))) %>%
    dplyr::group_by(cyl) %>%
    dplyr::summarise(dplyr::n())
  log("Returning result")
  result
}
