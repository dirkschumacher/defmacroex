`%>%` <- defmacro(function(lhs, rhs) {
  fun_args <- c(list(lhs), unlist(as.list(rhs[-1L]), FALSE))
  rlang::get_expr(rlang::quo(`!!`(rhs[[1L]])(!!!(fun_args))))
})

constexpr <- defmacro(function(expr) {
  eval(expr)
})

log <- defmacro(function(msg) {
  if (isTRUE(Sys.getenv("LOGGING") == "1")) {
    return(bquote(message(.(msg))))
  }
})

assert <- defmacro(function(msg, assertion_code) {
  if (isTRUE(Sys.getenv("ASSERT") == "1")) {
    return(assertion_code)
  }
})
