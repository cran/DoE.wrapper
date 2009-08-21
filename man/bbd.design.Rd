\name{bbd.design}
\alias{bbd.design}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Function for generating Box-Behnken designs }
\description{
  Function for generating Box-Behnken designs, 
  making use of package rsm 
}
\usage{
bbd.design(nfactors, ncenter=4, factor.names = NULL, default.levels=c(-1,1), 
          block.name=NULL, randomize=TRUE, seed=NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nfactors}{ number of factors }
  \item{ncenter}{ integer number of center points for each block }
  \item{factor.names}{ list of scale end values for each factor 
        (the middle value is calculated);\cr 
        names are used as variable names; \cr
        \bold{the names must not be x1, x2, ..., as these are used internally};\cr
        if the list is not named, the variable names are A, B and so forth;
        in the coded units used in attribute desnum, \code{-1} corresponds to the smaller, \code{+1} to the larger value. }
  \item{default.levels}{ default levels (vector of length 2) for all factors for 
      which no specific levels are given; must consist of two numeric values for the scale ends, 
      the default middle level is calculated }
  \item{block.name}{ name of block factor that distinguishes between the blocks;
        blocks are usable for nfactors=4 and nfactors=5 only, \code{blockname} is ignored otherwise. }
  \item{randomize}{ logical that indicates whether or not randomization should occur }
  \item{seed}{ seed for random number generation in randomization }
  \item{\dots}{ reserved for future usage}
}

\details{
   Function \code{bbd.design} creates a Box-Behnken design, which is a design for quantitative 
   factors with all factors on three levels. Box-Behnken designs should not be used if the combinations 
   of the extreme levels of the factors are of interest (cf. also Myers, Montgomery and Anderson-Cook 2009). 
   There are designs for 3 to 7 factors, and the unreplicated versions of these have 
   14 (3 factors), 24 (4 factors), 40 (5 factors), 48 (6 factors), and 56 (7 factors) runs 
   plus the specified number of center points \code{ncenter}.
   
   Function \code{bbd.design} is an interface to function \code{\link[rsm]{bbd}} from package \pkg{rsm} 
   that makes this design accessible using similar syntax as used in packages \pkg{DoE.base} and \pkg{FrF2} 
   and creates an output object that is also treatable by the convenience functions available in package 
   \pkg{DoE.base}.
   
   Currently, creation of replications and repeated measurements - as would be usual for other design 
   functions - is not implemented. This is planned for the future, but does not have high priority.
   }
\value{
    The function returns a data frame of S3 class \code{\link[DoE.base]{design}} 
    with attributes attached. The data frame itself is in the original data scale. 
    The matrix \code{desnum} attached as attribute \code{desnum} contains the coded data,
    the attribute \code{run.order} contains the standard order and the actual run order 
    of the design (contrary to package \code{rsm}, the row names of the design refer to 
    the actual rather than the standard run order).
    
    The attribute \code{design.info} is a list of design properties. 
    The element \code{type} of that list is the character string \code{bbd}. 
    Besides the elements present in all class \code{\link[DoE.base]{design}} objects, 
    there are the elements quantitative (vector with \code{nfactor} TRUE entries),
    and a \code{codings} element usable in the coding functions available in the \pkg{rsm} 
    package, e.g. \code{\link[rsm]{coded.data}}.
    
    }
\references{ 
  Box, G.E.P. and Behnken, D.W. (1960). Some new three-level designs for the study of 
    quantitative variables. \emph{Technometrics} \bold{2}, 455-475.

  Box, G.E.P., Hunter, J.S. and Hunter, W.G. (2005, 2nd ed.). \emph{Statistics for Experimenters}. 
    Wiley, New York.
     
  Box, G.E.P. and Wilson, K.B. (1951). On the Experimental Attainment of Optimum Conditions. 
    \emph{J. Royal Statistical Society}, \bold{B13}, 1-45.
    
  NIST/SEMATECH e-Handbook of Statistical Methods, 
    \url{http://www.itl.nist.gov/div898/handbook/pri/section3/pri3361.htm}, 
    accessed August 20th, 2009.
    
  Myers, R.H., Montgomery, D.C. and Anderson-Cook, C.M. (2009). \emph{Response Surface Methodology. 
      Process and Product Optimization Using Designed Experiments}. Wiley, New York.
}
\author{ Ulrike Groemping }
\note{ This package is currently under intensive development. Substantial changes are to be expected in the near future.}
\examples{
plan1 <- bbd.design(5)  ## default for 5 factors is unblocked design, contrary to package rsm
plan1
## blocked design for 4 factors, using default levels
plan2 <- bbd.design(4,block.name="block",default.levels=c(10,30))
plan2
desnum(plan2)
## design with factor.names and modified ncenter
bbd.design(3,ncenter=6, 
  factor.names=list("one"=c(25,35),"two"=c(-5,20), "three"=c(20,60)))
## design with character factor.names and default levels
bbd.design(3,factor.names=c("one","two", "three"), default.levels=c(10,20))
}
\seealso{ See also \code{\link[FrF2]{FrF2}}, \code{\link{ccd.design}}, \code{\link[lhs]{lhs}}, \code{\link[rsm]{rsm}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
