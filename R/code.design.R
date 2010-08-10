code.design <- function(design){
      ## function that applies coding information for subsequent application of rsm and its methods
      if (!"design" %in% class(design)) stop("code.design is applicable to class design objects only.")
      di <- design.info(design)
      if (is.null(di$coding)) {
          warning("code.design did not change anything,\nbecause the design does not contain coding information.")
          return(design)
          }
      else{
        design.info(design)$coding <- NULL
        hilf <- rep(list(c(-1,1)), di$nfactors)
        names(hilf) <- paste("x",1:di$nfactors, sep="")
        design.info(design)$factor.names <- hilf
        coded.data(design, formulas=di$coding)
        }
}