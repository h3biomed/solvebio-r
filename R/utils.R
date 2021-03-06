formatSolveBioResponse <- function (res, raw = FALSE) {
  url = res$url
  body = httr::content(res, as="text")
  if (raw) {
    return(body)
  } else {
    res = jsonlite::fromJSON(body)
    res$'_url' = url
    return(res)
  }
}

formatSolveBioQueryResponse <- function (res, raw = FALSE) {
    # res will be the output of formatSolveBioResponse
    if (!raw) {
        # Flatten the data frame
        res$results <- jsonlite::flatten(res$results)
    }
    return(res)
}

prepareArgs <- function (args) {
  if (!is.null(args) && length(args) > 0) {
    args = args[!sapply(args, is.null)]
    rapply(args, function (x) {
      ifelse(is.logical(x), x * 1, x)
    }, how="replace")
  } else {
    NULL
  }
}
