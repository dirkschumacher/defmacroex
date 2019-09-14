
<!-- README.md is generated from README.Rmd. Please edit that file -->

# defmacroex

<!-- badges: start -->

<!-- badges: end -->

Just an example of how to use the `defmacro` package.

## Example

The package exports a function called `analyze_dataset` with the
following code:

``` r
analyze_dataset <- function(data) {
  pipe({
    data
    dplyr::filter(hp > constexpr(50 + 50 + qnorm(0.975)))
    dplyr::group_by(cyl)
    dplyr::summarise(dplyr::n())
  })
}
```

At runtime, the code gets replaced by this through the use of macros:

``` r
defmacroex::analyze_dataset
#> function (data) 
#> {
#>     dplyr::summarise(dplyr::group_by(dplyr::filter(data, hp > 
#>         101.95996398454), cyl), dplyr::n())
#> }
#> <environment: namespace:defmacroex>
```
