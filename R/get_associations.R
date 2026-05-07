#' Get associations for a given variant
#'
#' Get all associations for a given variant
#'
#' @param rsnum RS number for a variant
#' @param chr chromosome number if known
#' @param p_lower Lower bound on p-values
#' @param p_upper Upper bound of p-values
#' @param study Restrict to a particular study
#' @param start First record to retrieve (starting at 0)
#' @param size Maximum number of results to retrieve
#'
#' @return Data frame with associations as rows
#'
#' @importFrom glue glue
#'
#' @examples
#' # get associations for a given variant
#' results <- get_variant("rs2228603")
#' # use information about the chromosome it's on
#' results <- get_variant("rs2228603", 19)
#' # get the next 20 results
#' next20 <- get_variant("rs2228603", 19, start=20)
#' # get 100 results rather than just 20
#' first100 <- get_variant("rs2228603", 19, size=100)
#' # return just the associations with P < 1e-8
#' top_results <- get_variant("rs2228603", 19, p_upper=1e-8)
#'
#' @seealso [get_asso()], [get_trait_asso()]
#' @export
get_variant <-
    function(rsnum, chr=NULL, p_lower=NULL, p_upper=NULL, study=NULL,
             start=NULL, size=NULL)
{
    url <- gwasapi_url()
    query <- glue("associations/{rsnum}")
    if(!is.null(chr)) query <- glue("chromosomes/{chr}/{query}")

    query_param <- NULL
    if(!is.null(p_lower)) query_param$p_lower <- p_lower
    if(!is.null(p_upper)) query_param$p_upper <- p_upper
    if(!is.null(p_lower) && !is.null(p_upper) && p_lower > p_upper) {
        stop("p_lower should be < p_upper")
    }
    if(!is.null(study)) query_param$study_accession <- study
    if(!is.null(start)) query_param$start <- start
    if(!is.null(size)) query_param$size <- size

    result <- query_gwasapi(query, query_param=query_param, url=url)
    list2df(result[["_embedded"]]$associations, exclude="_links")
}

#' Get GWAS associations for a given region
#'
#' Get GWAS associations for a given region
#'
#' @param chr chromosome number
#' @param bp_lower Lower endpoint of basepairs initerval
#' @param bp_upper Upper endpoint of basepairs initerval
#' @param study Restrict to a particular study
#' @param p_lower Lower bound on p-values
#' @param p_upper Upper bound of p-values
#' @param start First record to retrieve (starting at 0)
#' @param size Maximum number of results to retrieve
#'
#' @return Data frame of associations
#'
#' @examples
#' result <- get_asso(chr=19, bp_lower=19200000, bp_upper=19300000)
#' @seealso [get_variant()], [get_trait_asso()]
#' @export

get_asso <-
    function(chr, bp_lower=NULL, bp_upper=NULL, study=NULL,
             p_lower=NULL, p_upper=NULL, start=NULL, size=NULL)
{
    url <- gwasapi_url()
    query <- glue("chromosomes/{chr}/associations")

    query_param <- NULL
    if(!is.null(p_lower)) query_param$p_lower <- p_lower
    if(!is.null(p_upper)) query_param$p_upper <- p_upper
    if(!is.null(p_lower) && !is.null(p_upper) && p_lower > p_upper) {
        stop("p_lower should be < p_upper")
    }
    if(!is.null(study)) query_param$study_accession <- study
    if(!is.null(start)) query_param$start <- start
    if(!is.null(size)) query_param$size <- size
    if(!is.null(bp_lower)) query_param$bp_lower <- bp_lower
    if(!is.null(bp_upper)) query_param$bp_upper <- bp_upper

    result <- query_gwasapi(query, query_param=query_param, url=url)
    list2df(result[["_embedded"]]$associations, exclude="_links")
}


#' Get GWAS associations for a particular trait
#'
#' Get GWAS associations for a particular trait
#'
#' @param trait Restrict to a particular study
#' @param study Restrict to a particular study
#' @param p_lower Lower bound on p-values
#' @param p_upper Upper bound of p-values
#' @param start First record to retrieve (starting at 0)
#' @param size Maximum number of results to retrieve
#'
#' @return Data frame of associations
#'
#' @examples
#  this one tends to give a "too many requests" error
#' \dontrun{result <- get_trait_asso("EFO_0001360", p_upper=1e-10)}
#' @seealso [get_variant()], [get_asso()]
#' @export

get_trait_asso <-
    function(trait=NULL, study=NULL,
             p_lower=NULL, p_upper=NULL, start=NULL, size=NULL)
{
    url <- gwasapi_url()
    if(is.null(trait) && is.null(study)) {
        stop("Provide trait or study")
    }

    query <- "associations"
    if(!is.null(study)) query <- glue("studies/{study}/{query}")
    if(!is.null(trait)) query <- glue("traits/{trait}/{query}")

    query_param <- NULL
    if(!is.null(p_lower)) query_param$p_lower <- p_lower
    if(!is.null(p_upper)) query_param$p_upper <- p_upper
    if(!is.null(p_lower) && !is.null(p_upper) && p_lower > p_upper) {
        stop("p_lower should be < p_upper")
    }
    if(!is.null(start)) query_param$start <- start
    if(!is.null(size)) query_param$size <- size

    result <- query_gwasapi(query, query_param=query_param, url=url)
    list2df(result[["_embedded"]]$associations, exclude="_links")
}
