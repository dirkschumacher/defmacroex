
<!-- README.md is generated from README.Rmd. Please edit that file -->

# defmacroex

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

Just an example of how to use the
[`defmacro`](https://github.com/dirkschumacher/defmacro) package.

## Example

The package exports a function called `analyze_dataset` with the
following code that defines its own pipe function and a zero overhead
logging macro.

``` r
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
```

During package load, the code gets replaced by the expanded version of
the macro. This means the function does not have any runtime overhead.

``` r
defmacroex::analyze_dataset
#> function (data) 
#> {
#>     result <- dplyr::summarise(dplyr::group_by(dplyr::filter(data, 
#>         hp > 101.95996398454), cyl), dplyr::n())
#>     result
#> }
#> <bytecode: 0x7fc16f83fe70>
#> <environment: namespace:defmacroex>
```

Had we enabled logging through an environment variable, the logging code
would have been added to the function:

``` r
unloadNamespace("defmacroex")
withr::with_envvar(c("LOGGING" = "1", "ASSERT" = "1"), {
  defmacroex::analyze_dataset
})
#> function (data) 
#> {
#>     message("Computing result")
#>     stopifnot(is.data.frame(data))
#>     stopifnot(c("hp", "cyl") %in% colnames(data))
#>     result <- dplyr::summarise(dplyr::group_by(dplyr::filter(data, 
#>         hp > 101.95996398454), cyl), dplyr::n())
#>     message("Returning result")
#>     result
#> }
#> <bytecode: 0x7fc16eaa42f8>
#> <environment: namespace:defmacroex>
```
