\name{ccd.design}
\alias{ccd.design}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Functions for accessing central composite designs from package rsm }
\description{
  Functions for accessing central composite designs from package rsm, 
  and for augmenting existing fractional factorials in case of a late decision 
  for a frequential procedure. 
}
\usage{
ccd.design(nfactors=NULL, factor.names=NULL, default.levels=c(-1,1), ncube=NULL, 
        resolution=if (identical(blocks,1) & is.null(ncube)) 5 else NULL, 
        generators=NULL, ncenter = 4, alpha = "orthogonal", 
        replications=1, 
        block.name="Block.ccd", blocks=1, 
        randomize=TRUE, seed=NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nfactors}{ number of factors }
  \item{factor.names}{ list of cube corner values for each factor; 
        names are used as variable names; 
        if the list is not named, the variable names are X1, X2 and so forth;
        in coded units, \code{-1} corresponds to the smaller, \code{+1} to the larger value. }
  \item{default.levels}{ default levels (vector of length 2) for all factors for 
        which no specific levels are given }
  \item{ncube}{ integer number of cube points (without center points for the cube) }
  \item{resolution}{ arabic numeral for the requested resolution of the cube portion 
        of the design; cubes for ccd designs should usually be at least of resolution V. 
        the default value for resolution is therefore 5, unless \code{generators} 
        or \code{blocks} are specified, in which case the default is NULL}
  \item{generators}{ generators in the form allowed in function \code{\link[FrF2]{FrF2}} }
  \item{ncenter}{ integer number of center points for each cube or star point block, 
        or vector with two numbers, the first for the cube and the second for 
        the star portion of the design }
  \item{alpha}{ \dQuote{orthogonal}, \dQuote{rotatable}, 
        or a number that indicates the position of the star points;
        the number 1 would create a face-centered design. }
  \item{replications}{ the number of replications of the design; 
        currently, only proper replications can be generated;
        these are randomized in blocks within the center point and star blocks.
        The same number of replications is used for both the cube and the star blocks.}
  \item{block.name}{ name of block factor that distinguishes between blocks; 
        even for unblocked cubes, the ccd design has at least one cube and one star point block }
  \item{blocks}{ the same as in function \code{\link[FrF2]{FrF2}};\cr
       is EITHER \cr 
       the number of blocks into which the experiment is subdivided \cr
       OR a character vector of names of independent factors that are used as block constructors \cr
       OR a vector or list of generators similar to \code{generators}. \cr
       In the latter case, 
       the differences to \code{generators} are \cr 
       \itemize{
       \item that numbers/letters refer to the factors of the experiment and not to 
       column numbers of the Yates matrix 
       \item that numbers/letters can refer to *all* \code{nfactors} factors rather than the log2(nruns) base factors only, 
       \item that one single number is always interpreted as the number of blocks rather than a column reference, 
       \item that individual numbers are allowed in a list (i.e. individual factors specified in the experiment can be used as block factors) and
       \item that no negative signs are allowed. }
       
       If \code{blocks} is a single number, it must be a power of 2. 
       A blocked design can have at most \code{nruns-blocks} treatment 
       factors, but should usually have fewer than that. \cr
       
       If the experiment is randomized, randomization happens within blocks. \cr
       
       For the statistical and algorithmic background of blocked designs, see \code{\link[FrF2]{block}}.
       }
  \item{randomize}{ logical that indicates whether or not randomization should occur }
  \item{seed}{ NULL or a vector of two integer seeds for random number generation in randomization }
  \item{\dots}{ reserved for future usage}
}
\details{
    The statistical background of central composite designs is briefly described 
    under \code{\link{CentralCompositeDesigns}}.
    
   Function \code{ccd.design} creates a central composite design from scratch. 
   It proceeds by generating a cube design with function \code{\link[FrF2]{FrF2}} and then 
   augmenting this cube design using functions \code{\link[FrF2]{add.center}} from package 
   \pkg{FrF2} for adding center points to the cube and subsequently function 
   \code{\link[rsm]{ccd}} from package \pkg{rsm} for generating the star portion of 
   the design. 
   
   There are two main purposes for this function: one is to provide 
   central composite designs within the same syntax philosophy 
   used in packages \code{\link[DoE.base]{DoE.base-package}} and \code{\link[FrF2]{FrF2}}. 
   The other is to automatically identify good (=resolution V) cube portions, 
   which can be achieved by using the resolution parameter.

   In comparison to direct usage of package \pkg{ccd}, the functions make the syntax closer to 
   that of the other packages in the DoE.wrapper suite and allow automatic selection of fractional 
   factorials as cubes. 
   
   Function \code{ccd.design} does not allow direct use of the \code{estimable} functionality 
   that is available in function \code{\link[FrF2]{FrF2}}. Nevertheless, ccd designs with a cube 
   based on the \code{estimable} functionality can be generated 
   by first using function \code{FrF2} and subsequently applying 
   function \code{\link{ccd.augment}}. It may for example be interesting to use designs based on 
   estimability requirements for 2-factor interactions in cases where a resolution V cube 
   for the ccd is not feasible - of course, this does not allow to estimate the full second order model
   and therefore generates a warning.
   
   }
\value{
    The function returns a data frame of S3 class \code{\link[DoE.base:class-design]{design}} 
    with attributes attached. The data frame itself is in the original data scale. 
    The data frame \code{desnum} attached as attribute \code{desnum} is the coded design. 
    The attribute \code{design.info} is a list of various design properties. 
    The element \code{type} of that list is the character string \code{ccd}.
    Besides the elements present in all class \code{\link[DoE.base:class-design]{design}} objects, 
    there are the elements quantitative (vector with \code{nfactor} TRUE entries),
    and a \code{codings} element usable in the coding functions available in the \pkg{rsm} 
    package, e.g. \code{\link[rsm]{coded.data}}.
    
    Note that the row names and the standard order column in the 
    \code{run.order} attribute of ccd designs 
    are not in conventional order, 
    if the blocking routine \code{\link[FrF2:blockpick]{blockpick.big}} was used. 
    In such situations, these should not be used as the basis for any calculations. 
    }
\references{ 
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
ccd.design(5) ## per default uses the resolution V design in 16 runs for the cube
ccd.design(5, ncube=32) ## uses the full factorial for the cube
ccd.design(5, ncenter=6, default.levels=c(-10,10))
## blocked design (requires ncube to be specified)
ccd.design(5, ncube=32, blocks=4) 
## there is only one star point block

## for usage of other options, look at the FrF2 documentation
}
\seealso{ See also \code{\link{ccd.augment}}, \code{\link[FrF2]{add.center}}, 
\code{\link[FrF2]{FrF2}}, \code{\link[lhs]{lhs-package}}, \code{\link[rsm]{rsm}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
