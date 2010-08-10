\name{rsmformula}
\alias{rsmformula}
\alias{code.design}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Functions for supporting response surface analysis with package rsm }
\description{
    These functions support response surface analysis with package rsm. 
    Function rsmformula creates a model formula for use with function rsm, 
    using the FO, TWI and PQ notation. Function code.design prepares a ccd, bbd 
    or lhs design from this package for convenient use with package rsm functionality.
    }
\usage{
code.design(design)
rsmformula(design, response=NULL, factor.names=NULL, 
    use.blockvar = TRUE, degree=2, coded=TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{design}{ a response surface design of class \code{design} 
        with at least one response variable and 
        of a type derived from \code{ccd}, \code{bbd}, or \code{lhs}}
  \item{response}{ character string specifying the response variable to be analysed 
        (default: the first response of the design) }
  \item{factor.names}{ character vector specifying the factors to be included 
        (default: all experimental factors) }
  \item{use.blockvar}{ logical indicating whether or not the block effect (if available) 
        is to be included into the model }
  \item{degree}{ default is 2 for a full second order model. 
        For a first order only model, specify 1; 
        for a model with main effects and 2-factor interactions, specify 1.5. 
        \code{degree} corresponds to the \code{order} element of the object created by 
        function \code{\link{rsm}}. }
  \item{coded}{ logical indicating whether the formula is to be provided in 
        coded names (x1, x2 etc., \code{coded=TRUE}) or original variable names (\code{coded=FALSE})}
  \item{\dots}{ reserved for future usage}
}

\details{
   Function \code{code.design} rescales the variables of a design with quantitative 
   variables according to the information stored in the \code{coding} element of 
   the \code{design.info} attribute of \code{design}. 

   Function \code{rsmformula} creates a formula for use with function \code{\link[rsm:rsm]{rsm}}. 
   If this function is created in coded variable names (which is the default), 
   it can be used in function \code{\link[rsm:rsm]{rsm}} 
   together with the coded data object created by function \code{code.design} 
   for creating a response surface model, which can be post-processed by the utilities provided 
   in package \pkg{rsm}, especially the \code{[rsm:rsm]{methods}} for class \code{rsm} objects 
   and functions \code{\link[rsm:steepest]{steepest}} or \code{\link[rsm:steepest]{canonical.path}}. 
   
   IMPORTANT: coded vs. original units\cr
   The text below assumes that the design has been entered using the \code{default.levels} or the 
   \code{factor.names} option to specify the factor levels in original units.\cr
   The usual steepest ascent analysis is done
   in coded units, i.e. if e.g. factor X1 has original units 10 (code -1 = (10-20)/10) 
   and 30 (code +1 = (30-20)/10) 
   and factor X2 has original units 0.1 (code -1 = (0.1 - 0.2)/0.1) 
   and 0.3 (code +1 = (0.3 - 0.2)/0.1), 
   an increase of 10 for a change in factor X1 from 10 to 30 is considered 
   steeper (slope 10/2) than an increase of 9 for a change in factor X2 
   from 0.1 to 0.3 (slope 9/2). If this behavior is 
   desired, usage of \code{rsmformula} with option coded=TRUE and a design generated 
   by \code{code.design} is needed. \cr
   Otherwise, i.e. when assessment is desired 
   in original units, the ascent for factor X2 (9/0.2) would of course be much steeper  
   than for factor X1 (10/20) in the above example. For obtaining an assessment based 
   on the original units, one can simply use \code{rsmformula} with option coded=FALSE 
   and the design itself in original units in the 
   \code{\link[rsm]{rsm}} model. This only makes sense for first order models: 
   function \code{\link[rsm]{steepest}} always assesses the slope at the origin; 
   for first order models, it does not matter where the slope is assessed. For models 
   with order (=\code{degree}) 1.5 or 2, the \code{steepest} analysis is adequate only for the exceptional 
   case that 0 is the point of interest.
   }
\value{
    Function \code{code.design} returns a \code{\link[rsm:coded.data]{coded.data}} object 
    for usage with function \code{\link[rsm:rsm]{rsm}}.

    Function \code{rsmformula} returns a formula with an \code{FO} (=first order) portion, 
    for \code{degree=1.5} additionally a \code{TWI} (=two factor interactions, 2fis) portion,
    and for \code{degree=2} also a \code{PQ} (=pure quadratic) portion. 

    This representation of the model formula is needed for response surface analyses 
    with package \pkg{rsm}. Per default, the formula comes 
    in coded variable names (\code{x1}, \code{x2} etc.).
    }
\references{ 
  Lenth, R.V. (2009). Response-Surface Methods in R, using \pkg{rsm}.
      \emph{Journal of Statistical Software} \bold{32}(7), 1-17. 
      URL{http://www.jstatsoft.org/v32/i07/}.
    
  Myers, R.H., Montgomery, D.C. and Anderson-Cook, C.M. (2009). \emph{Response Surface Methodology. 
      Process and Product Optimization Using Designed Experiments}. Wiley, New York.
}
\author{ Ulrike Groemping }
\note{ This package is currently under intensive development. Substantial changes are to be expected in the near future.}
\examples{
  ## an artificial example with random response
  ## purely for demonstrating how the functions work together with rsm
  plan <- ccd.design(5, ncenter=6, 
         factor.names = list(one=c(10,30),two=c(1,5),three=c(0.1,0.9),
                             four=c(2,4),five=c(-1,1)))
  set.seed(298)
  plan <- add.response(plan, rnorm(38))
  
  ## coding
  plan.c <- code.design(plan)
  plan.c
  
  ## first order analysis
     ## formulae needed for first order models:
    rsmformula(plan, degree=1)                ## coded
    rsmformula(plan, degree=1, coded=FALSE)   ## original units
    
    ## steepest ascent: steepness assessed in coded units, 
    ## results also presented in original units
    linmod1 <- rsm(rsmformula(plan, degree=1), data=plan.c)
    summary(linmod1)
    steepest(linmod1)
    
    ## steepest ascent: steepness assessed in original units!!! 
    ## this is different from the usual approach!!! 
    ## cf. explanation in Details section
    linmod1.original <- rsm(rsmformula(plan, degree=1, coded=FALSE), data=plan)
    summary(linmod1.original)
    steepest(linmod1.original)

  ## second order analysis (including quadratic, degree=1.5 would omit quadratic
    ## formulae needed for second order models:
    rsmformula(plan, degree=2)               ## coded
    rsmformula(plan, degree=2, coded=FALSE)  ## original units
       ## the formulae can also be constructed analogously to the FO formulae 
       ## by using SO instead of FO
       ## rsmformula returns the more detailed function because 
       ##     it can be more easily modified to omit one of the effects
    
    ## the stationary point is not affected by using coded or original units
    ##     neither is the decision about the nature of the stationary point
    ## a subsequent canonical path analysis will however be affected,
    ##     analogously to the steepest ascent (cf. Details section)
    
    ## analysis in coded units
    linmod2 <- rsm(rsmformula(plan, degree=2), data=plan.c)
    summary(linmod2)
    ## analysis in original units
    linmod2.original <- rsm(rsmformula(plan, degree=2, coded=FALSE), data=plan)
    summary(linmod2.original)
    ## the contour plot may be nicer when using original units
    contour(linmod2, form=~x1*x2)
    contour(linmod2.original, form=~one*two)
    ## the canonical path is usually more reasonable in coded units
    canonical.path(linmod2)            ## coded units
    canonical.path(linmod2.original)   ## original units
    
    ## analogous analysis without the special formula notation of function rsm
    linmod <- rsm(rnorm.38. ~ Block.ccd + (one + two + three + four + five)^2 + 
          I(one^2) + I(two^2) + I(three^2) + I(four^2) + I(five^2), data=plan)
    summary(linmod)
    contour(linmod, form=~one*two)  ## contour plot is possible
    ## steepest or canonical.path cannot be used, 
    ## because the model is a conventional lm
 
    ## contour will not work on the convenience model
    ## lm(plan), which is otherwise identical to linmod
    ## (it will neither work on lm(formula(plan), plan))
    ## or lm(rsmformula(plan), plan)
   }
\seealso{ See also \code{\link[rsm]{rsm}}, 
    \code{\link[rsm]{steepest}}, \code{\link[rsm:steepest]{canonical.path}}, 
    \code{\link[rsm]{contour.lm}},
    . 
    The \code{\link[DoE.base:formula.design]{formula}} method for class \code{design} objects 
    creates equivalent model formulae in standard model notation.
 }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
