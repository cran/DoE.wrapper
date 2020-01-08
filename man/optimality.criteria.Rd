\name{optimality.criteria}
\alias{optimality.criteria}
\alias{Scalc}
\alias{compare}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Overview of optimality criteria in experimental design packages}
\description{
  One function for calculating the S-optimality criterion is provided here. 
  This help file documents this function and also describes optimality criteria from 
  other related packages, referring to space filling optimality like the S criterion 
  or to model-based optimality like the well-known D-criterion.
}
\usage{
Scalc(design)
compare(...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{design}{ matrix, often normalized to unit cube, \cr
        OR\cr
        design (class \code{design}) of type \code{lhs} or \code{Dopt}.\cr
        For \code{design} objects, calculations are applied to the 
        \code{desnum} attribute.}
  \item{\dots}{two or more designs, either all of type \code{lhs} or all of type \code{Dopt}, 
        can be compared w.r.t. some optimality criteria that are stored 
        in their \code{design.info} attribute (only works with designs created 
        by \pkg{DoE.wrapper} version 0.7 or higher)}
        }
\details{
   Function \code{Scalc} calculates the S criterion for optimality, which is 
   employed in package \pkg{lhs} for most optimization purposes (exception: 
   maximin designs). The criterion is the harmonic mean of all pairwise 
   interpoint distances, and space-filling optimization tries to maximize it. 
   
   Function \code{\link[AlgDesign]{eval.design}} from package \pkg{AlgDesign} 
   calculates various model-based optimality criteria: 
   \describe{
     \item{confounding}{a confounding matrix of effects, if requested}
     \item{determinant}{the k-th root of the determinant of Z'Z/N, where Z is the 
     model matrix of the model under investigation, k is the number of columns 
     of Z and N the number of rows; this is the quantity optimized for D-optimal 
     designs}
     \item{A}{the arithmetic mean of coeffient variance multipliers, 
     i.e. the average diagonal element of the inverse of Z'Z/N, intercept included}
     \item{I}{the average prediction variance over a space X; calculated only, if X is specified}
     \item{Ge}{the minimax normalized variance over X; calculated only, if X is specified}
     \item{Dea}{A lower bound on D efficiency for approximate theory designs. 
     It is equal to exp(1-1/Ge), i.e. is also calculated only, if X is specified.}
     \item{diagonality}{the k-th root of the ratio of the determinant of M1 
     divided by the product of diagonal elements of M1, 
     where M1 is Z'Z with the column and row referring to the intercept removed, 
     and k the number of columns of M1; if this is 1, the coefficient estimates 
     are uncorrelated.}
     \item{gmean.variances}{the geometric mean of normalized coeffient variance multipliers
     (intercept excluded), i.e. the geometric mean of the diagonal elements of the inverse of Z'Z/N, 
     without the first element, if an intercept is in the model.}
   }

   Several functions from package \pkg{DiceDesign} calculate optimality criteria 
   regarding the space filling qualities of a design. These functions 
   normalize the design to lie in the unit cube, 
   if it does not yet do so. Application of these functions 
   to designs with qualitative factors does not make sense and 
   yields errors. The following functions are available:\cr
   
   \code{\link[DiceDesign]{mindist}} calculates the minimum distance between 
   any pair of design points. This is the criterion which is maximized by 
   maximin designs, i.e. should be large for a space-filling design. 
   
   For the next two distance metrics, it is helpful to define \code{g_i} as the minimal 
   distance of design point \code{i} to any other design point.
   
   \code{\link[DiceDesign]{meshRatio}} calculates the ratio of the 
   maximum \code{g_i} to the minimum \code{g_i} 
   (a small mesh ratio indicates a similar minimal 
   distance for all design points).  

   \code{\link[DiceDesign]{coverage}} calculates the coefficient of variation 
   of the \code{g_i}, however using the denominator \code{n} instead of \code{n-1} 
   for the standard deviation (a large coverage indicates that the average minimal 
   distance for of design points is large relative to their standard deviation; 
   large values are desirable).
   
   Function \code{\link[DiceDesign]{discrepancyCriteria}} calculates 
   several versions of L2 discrepancy. 
   
   Function \code{link[skpr]{eval_design}} calculates effect and parameter powers 
   for a design for a specified model and a specified significance level \code{alpha}. 
   }
\value{
   Function \code{Scalc} returns a single number: the harmonic mean of all pairwise interpoint distances 
   is calculated, based on the matrix \code{design} or the desnum attribute of the design \code{design}. 
   (This value should be as large as possible for a space-filling design.) 
   
   Note that the resulting S value differs from the printed optimum value by function \code{lhs.design} for 
   type \code{optimum} in two respects: the printed optimum value is the sum of inverse distances, 
   i.e. the denominator of the harmonic mean. choose(nruns, 2) divided by the printed final optimal value 
   is approximately equal to the calculated S; perfect equality cannot be achieved 
   because the underlying the printed final optimum refers to an interim latin hypercube of integers 
   that is subsequently rescaled to the unit cube and scrambled by random numbers.
   
   Function \code{compare} returns a matrix, with rows representing the criteria 
   and columns the different designs. Apart from many of the criteria mentioned above, the 
   determinant of the correlation matrix is shown, which should ideally be close to one for 
   a near-orthogonal design (at least in terms of linear effects).
    }
\author{ Ulrike Groemping }
\note{ This package is still under (slow) development. Reports about bugs and inconveniences are welcome.  }
\references{ 
  Beachkofski, B., Grandhi, R. (2002) Improved Distributed Hypercube Sampling. American Institute of Aeronautics and Astronautics Paper 1274.
  
  Currin C., Mitchell T., Morris M. and Ylvisaker D. (1991) 
  Bayesian Prediction of Deterministic Functions With Applications to the Design and Analysis of Computer Experiments, 
  \emph{Journal of the American Statistical Association} \bold{86}, 953--963.

  Santner T.J., Williams B.J. and Notz W.I. (2003) The Design and Analysis of Computer Experiments, Springer, 121--161.
  
  Shewry, M. C. and Wynn and H. P. (1987) Maximum entropy sampling. \emph{Journal of Applied Statistics} \bold{14}, 165--170.
  
  Fang K.-T., Li R. and Sudjianto A. (2006) \emph{Design and Modeling for Computer Experiments}, Chapman & Hall.

  Stein, M. (1987) Large Sample Properties of Simulations Using Latin Hypercube Sampling. \emph{Technometrics} \bold{29}, 143--151. 
  
  Stocki, R. (2005) A method to improve design reliability using optimal Latin hypercube sampling. 
      \emph{Computer Assisted Mechanics and Engineering Sciences} \bold{12}, 87--105.
  
  
}
\examples{
   ## optimum design from package lhs (default)
   plan <- lhs.design(20,4,"optimum",
          factor.names=list(c(15,25), c(10,90), c(0,120), c(12,24)), digits=2)
   ## maximin design 
   plan2 <- lhs.design(20,4,"maximin",
          factor.names=list(c(15,25), c(10,90), c(0,120), c(12,24)), digits=2)
   ## purely random design (usually not ideal)
   plan3 <- lhs.design(20,4,"random",
          factor.names=list(c(15,25), c(10,90), c(0,120), c(12,24)), digits=2)
   ## genetic design 
   plan4 <- lhs.design(20,4,"genetic",
          factor.names=list(c(15,25), c(10,90), c(0,120), c(12,24)), digits=2)
   ## dmax design from package DiceDesign
   ## arguments range and niter_max are required
   ## ?dmaxDesign for more info
   plan5 <- lhs.design(20,4,"dmax",
        factor.names=list(torque=c(10,14),friction=c(25,35),
              temperature=c(-5,35),pressure=c(20,50)),digits=2,
              range=0.2, niter_max=500)
   ## Strauss design from package DiceDesign
   ## argument RND is required
   ## ?straussDesign for more info
   plan6 <- lhs.design(20,4,"strauss",
        factor.names=list(torque=c(10,14),friction=c(25,35),
              temperature=c(-5,35),pressure=c(20,50)),digits=2,
              RND = 0.2)
   ## compare all these designs
   compare(plan, plan2, plan3, plan4, plan5, plan6)
   }
\seealso{ See Also \code{\link[lhs]{lhs-package}}, 
    \code{\link[DiceDesign]{DiceDesign-package}}, 
    \code{\link[AlgDesign]{eval.design}}, 
    \code{\link[skpr]{eval_design}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
