\name{Dopt.augment}
\alias{Dopt.augment}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Function for augmenting a design with D-optimal additional points using optFederov from package AlgDesign }
\description{
  Function for comfortably augmenting a design with D-optimal additional points;
  this functionality is still somewhat experimental.
}
\usage{
Dopt.augment(design, m=1, formula=NULL, candidates=NULL, constraint=NULL, 
    center=FALSE, nRepeats=5, 
    seed=NULL, randomize=TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{design}{an experimental design of class \code{design}, 
        which may not be a blocked, split-plot, neither 
        crossed or parameter design; it also must not be replicated with repeat.only replications. 
        }
  \item{m}{integer number of additional points to add to design \code{design} }
  \item{formula}{ a model formula, for the estimation of which a D-optimal design is sought;\cr
        it can contain all column names from \code{data} 
        or elements or element names from \code{factor.names}, respectively;\cr
        usage of the \dQuote{.}-notation for \dQuote{all variables} from \code{data} or \code{factor.names} 
        is possible. \cr
        The default formula (if the value \code{NULL} is not changed) is the formula associated with 
        the design (by function \code{formula.design}). 
        
        For quantitative factors, functions \code{quad()} and \code{cubic} describe the 
        full quadratic or full cubic model in the listed variables (cf. examples 
        and the \code{\link[AlgDesign]{expand.formula}}-function from package \pkg{AlgDesign}).  
        }
  \item{candidates}{data frame of candidate points; if not specified, candidates 
        are constructed as a full factorial from the 
        \code{factor.names} element of the \code{design.info} attribute of \code{design}}
  \item{constraint}{ a condition (character string!) used for reducing the candidate 
        set to admissible points only. \cr
        \code{constraint} is evaluated on the specified data set or after automatic creation 
        of a full factorial candidate data set.\cr 
        The variable names from \code{data} or \code{factor.names} can be used by the constraint.\cr
        Per default (i.e. if the constraint is \code{NULL}), the constraint attribute from 
        \code{design} is used. \cr
        If a previously-applied constraint is to be removed, specify \code{constraint = ""}.\cr
        It is not possible to apply a constraint that is already violated by the 
        design that is to be augmented.
        }
  \item{center}{ requests that optimization is run for the centered model; 
        the design is nevertheless output in non-centered coordinates
        }
  \item{nRepeats}{ number of independent repeats of the design optimization process; 
        increasing this number may improve the chance of finding a global optimum, 
        but will also increase search time
        }
  \item{seed}{ seed for generation and randomization of the design (integer number);\cr 
        here, the seed is needed even if the design is not randomized, because the 
        generation process for the optimum design involves random numbers, even if the 
        order of the final design is not randomized;\cr
        if a reproducible design is needed, it is therefore recommended to specify a seed }
  \item{randomize}{ logical deciding whether or not the design should be randomized; 
        if it is \code{TRUE}, the design (or the additional portion of the design) returned by the 
        workhorse function \code{\link[AlgDesign]{optFederov}} is brought 
        into random order after generation. Note that the generation process 
        itself contains a random element per default; if exact repeatability for the 
        returned design is desired, it is necessary to specify a seed (option \code{seed}) 
        if in the case \code{randomize=FALSE}. }
  \item{\dots}{ additional arguments to function \code{\link[AlgDesign]{optFederov}} 
        from package \pkg{AlgDesign};\cr 
        interesting arguments: \code{maxIteration}, 
        \code{nullify} (calculate good starting design, especially set to 1, 
        in which case \code{nRepeats} is set to 1;\cr 
        arguments \code{criterion} and \code{augment} are not available, neither 
        are \code{evaluateI}, \code{space}, or \code{rows}, and \code{args} 
        does not have an effect. }
}
\details{
   Function \code{Dopt.augment} augments an existing design by \code{m} D-optimal 
   additional points (unblocked designs, no split-plot, no parameter or crossed design, 
   no repeat.only replications), i.e. by points that make the design particularly efficient 
   for the intended model. 
   
   Option \code{center}, which is available for both blocked and unblocked designs as part of the \dots argument, 
   requests optimization for the centered model; the design that is created is nevertheless an uncentered design.
   
   NULL entries in the arguments are filled with automatic values that are determined 
   from \code{design}.
   }
\value{
    The function returns a data frame of S3 class \code{\link[DoE.base:class-design]{design}} 
    with attributes attached. 
    The data frame contains the experimental settings.
    The matrix \code{desnum} attached as attribute \code{desnum} contains the 
    model matrix of the design, using the formula as specified in the call. \cr
    Function \code{Dopt.augment} preserves additional variables (e.g. responses) that 
    have been added to the design \code{design} before augmenting. Note, however, that 
    the response data are NOT used in deciding about which points to augment the design with.
    
    The attribute \code{run.order} provides the run number in standard order (as returned from 
    function \code{\link[AlgDesign]{optFederov}} in package \pkg{AlgDesign}) as well 
    as the randomized actual run order. The third column is always identical to the first.

    The attribute \code{design.info} is a list of various design properties, with type resolving to \dQuote{Dopt.augment}. 
    In addition to the standard list elements (cf. \code{\link[DoE.base:class-design]{design}}), the element 
    \code{quantitative} is a vector of \code{nfactor} logical values or NAs, 
    and the optional \code{digits} elements indicates the number of digits to 
    which the data were rounded. 
    The list contains further entries regarding the optimality that has been achieved 
    (\code{D}, \code{Dea} and \code{A}). 
    
    Note that the original design is contained in the first rows of the new data set. 
    The original design also contains columns that are not directly part of the 
    design, e.g. comment columns. \cr
    Note that \code{replications} is always set to 1, even if the original design was 
    replicated, and \code{repeat.only} is always FALSE. 
    These elements are only present to fulfill the formal requirements for class \code{design}.)
    }
\author{ Ulrike Groemping }
\note{ This package is currently under intensive development. Substantial changes are to be expected in the near future.}
\references{ 
  Atkinson, A.C. and Donev, A.N. (1992). \emph{Optimum experimental designs}. Clarendon Press, Oxford. 

  Federov, V.V. (1972). \emph{Theory of optimal experiments}. Academic Press, New York. 

  Wheeler, R.E. (2004). \emph{Comments on algorithmic design}. Vignette accompanying package \pkg{AlgDesign}. 
       \url{../../AlgDesign/doc/AlgDesign.pdf}.
}
\examples{
   ## a full quadratic model with constraint in three quantitative factors 
   plan <- Dopt.design(36,factor.names=list(eins=c(100,250),zwei=c(10,30),drei=c(-25,25)),
                          nlevels=c(4,3,6), 
                          formula=~quad(.), 
                          constraint="!(eins>=200 & zwei==30 & drei==25)")
   summary(plan)
   y <- rnorm(36)
   r.plan <- add.response(plan, y)
   plan2 <- Dopt.augment(r.plan, m=10)
   summary(plan2)
   ## add the new response valued after conducting additional experiments
   y <- c(y, rnorm(10))
   r.plan2 <- add.response(plan2,y, replace=TRUE)
   summary(r.plan2, brief=FALSE)
   
}
\seealso{ See also \code{\link[AlgDesign]{optFederov}}, \code{\link[DoE.base]{fac.design}}, 
    \code{\link[AlgDesign:expand.formula]{quad}}, \code{\link[AlgDesign:expand.formula]{cubic}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
