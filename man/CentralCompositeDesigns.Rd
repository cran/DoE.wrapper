\name{CentralCompositeDesigns}
\alias{CentralCompositeDesigns}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Statistical background of central composite designs }
\description{
  Brief description of the statistical background of 
  central composite designs 
}
\details{
    Central composite designs (ccd's) were invented by Box and Wilson (1951) 
    for response surface experimentation with quantitative factors. 
    They are used for estimation of second order 
    response surface models, i.e. models that allow to estimate linear, quadratic and 
    interaction effects for all factors. 
    
    Central composite designs consist of a cube and star points (also called 
    axial points). Both the cube and the star portion of the design should have some center 
    points. The cube is a (fractional) factorial design and should be at least of resolution V. 
    The line between the center points and the star points intersects the faces of the cube 
    in their middle (see the link to the NIST/Sematech e-Handbook 
    for a visualization). There are two star points per factor, i.e. the number of runs 
    for (each block of) the star 
    portion of the design is twice the number of factors plus the number of center points 
    in the star portion. 
    
    The tuning parameter \code{alpha} determines whether the star points lie on the 
    faces of the cube (\code{alpha=1}, face-centered), inside the cube (\code{alpha<1}, 
    inscribed) or outside the cube (\code{alpha>1}, circumscribed). 
    The latter case is the usual one. The value of 
    \code{alpha} can be chosen such that the design is rotatable (may be useful if the scales 
    of the factors are comparable) or such that the design is orthogonally blocked 
    (i.e. the block effects do not affect the effect estimates of interest). The default 
    is to generate orthogonally blocked designs.
    
    Central composite designs are particularly useful in sequential experimentation, 
    where a (fractional) factorial with center points is followed up by a star portion 
    of the design. While the cube can already estimate the linear and interaction effects, 
    the center points can only estimate the sum of all quadratic effects. If this indicates 
    that quadratic effects are important, a star portion can be added in order to investigate 
    the model more deeply.
   }
\references{ 
  Box, G.E.P., Hunter, J.S. and Hunter, W.G. (2005, 2nd ed.). \emph{Statistics for Experimenters}. 
    Wiley, New York.
     
  Box, G.E.P. and Wilson, K.B. (1951). On the Experimental Attainment of Optimum Conditions. 
    \emph{J. Royal Statistical Society}, \bold{B13}, 1-45.
    
  NIST/SEMATECH e-Handbook of Statistical Methods, 
    \url{http://www.itl.nist.gov/div898/handbook/pri/section3/pri3361.htm}, 
    accessed August 20th, 2009.
    
  Myers, R.H., Montgomery, D.C. and Anderson-Cook, C.M. (2009). Response Surface Methodology. 
      Process and Product Optimization Using Designed Experiments. Wiley, New York.

}
\author{ Ulrike Groemping }
\note{ This package is still under (slow) development. Reports about bugs and inconveniences are welcome.  }
\seealso{ See Also \code{\link[rsm]{ccd}}, \code{\link{ccd.design}}, \code{\link{ccd.augment}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
