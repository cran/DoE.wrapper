\name{DoE.wrapper-page}
\alias{DoE.wrapper-page}
\alias{DoE.wrapper}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Wrapper package for design of experiments functionality }
\description{
  This package creates various kinds of designs for (industrial) experiments. 
  It uses, and sometimes enhances, design generation routines from other packages. 
  Initially, response surface designs from package rsm and latin hypercube samples 
  from package lhs have been implemented.
}
\details{
   Currently, the package provides classical response surface designs from package 
   \pkg{rsm}: Box-Behnken designs by Box and Behnken (function \code{\link{bbd.design}} 
   and central composite designs by Box and Wilson (\code{\link{ccd.design}}) are implemented. 
   For the latter, there is also a function for augmenting 2-level fractional factorials 
   into central composite designs (\code{\link{ccd.design}}).
   
   Furthermore, latin hypercube samples from package \pkg{lhs} are provided. 
   
   It is planned to also provide access to D-optimal 
   designs using package \pkg{AlgDesign}. This may take some time, however.
   
   All functions in this package provide class \code{\link[DoE.base]{design}} objects, 
   which are data frames with attributes.
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
\seealso{ See also \code{\link{ccd.design}}, \code{\link{ccd.augment}}, \code{\link{bbd.design}}, \code{\link{lhs.design}}, 
    \code{\link[lhs]{lhs}}, \code{\link[rsm]{rsm}}, \code{\link[FrF2]{FrF2}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
