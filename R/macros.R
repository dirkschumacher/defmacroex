pipe <- defmacro::defmacro(function(expr) {
  Reduce(function(acc, el) {
    fun_name <- el[[1L]]
    fun_args <- c(list(acc), unlist(as.list(el[-1L]), FALSE))
    rlang::get_expr(rlang::quo(`!!`(fun_name)(!!!(fun_args))))
  }, expr[-1L])
})

constexpr <- defmacro::defmacro(function(expr) {
  eval(expr)
})

log <- defmacro::defmacro(function(msg) {
  if (isTRUE(Sys.getenv("LOGGING") == "1")) {
    return(bquote(message(.(msg))))
  }
})

assert <- defmacro::defmacro(function(msg, assertion_code) {
  if (isTRUE(Sys.getenv("ASSERT") == "1")) {
    return(assertion_code)
  }
})
