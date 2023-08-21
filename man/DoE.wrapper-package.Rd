\name{DoE.wrapper-package}
\alias{DoE.wrapper-package}
\alias{DoE.wrapper}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Wrapper package for design of experiments functionality }
\description{
  This package creates various kinds of designs for (industrial) experiments. 
  It uses, and sometimes enhances, design generation routines from other packages. 
  So far, response surface designs from package rsm, designs for computer 
  experiments (latin hypercube samples etc.) from packages lhs and DiceDesign 
  and D-optimal designs from package AlgDesign have been implemented.
}
\details{
   Currently, the package provides classical response surface designs from package 
   \pkg{rsm}: Box-Behnken designs by Box and Behnken (function \code{\link{bbd.design}} 
   and central composite designs by Box and Wilson (\code{\link{ccd.design}}) are implemented. 
   For the latter, there is also a function for augmenting 2-level fractional factorials 
   into central composite designs (\code{\link{ccd.design}}).
   
   Furthermore, latin hypercube samples and other designs for computer experiments 
   from packages \pkg{lhs} and \pkg{DiceDesign} are provided. 
   
   Furthermore, D-optimal designs have been implemented, 
   using package \pkg{AlgDesign}. This implementation is currently in beta shape.
   
   All designs created by this package are class \code{\link[DoE.base:class-design]{design}} objects, 
   which are data frames with attributes.
   
   Apart from providing designs, the package also provides functions for comparing 
   the quality of several designs with quantitative variables (function \code{compare}).
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
\note{ This package is still under (slow) development. Reports about bugs and inconveniences are welcome.}
\seealso{ See also \code{\link{ccd.design}}, \code{\link{ccd.augment}}, \code{\link{bbd.design}}, \code{\link{lhs.design}}, 
    \code{\link{Dopt.design}}, \code{\link{Dopt.augment}},
    \code{\link[lhs]{lhs-package}}, \code{\link[rsm]{rsm}}, \code{\link[AlgDesign]{optFederov}}, 
    \code{\link[AlgDesign]{optBlock}}, \code{\link{compare}}, \code{\link[FrF2]{FrF2}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
