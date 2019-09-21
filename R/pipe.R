#' Analyze a dataset
#'
#' @param data the dataset
#'
#' @export
#' @include macros.R
analyze_dataset <- function(data) {
  log("Computing result")
  result <- pipe({
    data
    dplyr::filter(hp > constexpr(50 + 50 + qnorm(0.975)))
    dplyr::group_by(cyl)
    dplyr::summarise(dplyr::n())
  })
  log("Returning result")
  result
}
