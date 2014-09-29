\name{Dopt.design}
\alias{Dopt.design}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Function for creating D-optimal designs with or without blocking from package AlgDesign }
\description{
  Function for comfortably creating a D-optimal design with or without blocking 
  based on functions optFederov or optBlock from package AlgDesign;
  this functionality is still somewhat experimental.
}
\usage{
Dopt.design(nruns, data=NULL, formula=~., factor.names=NULL, nlevels=NULL, 
    digits=NULL, constraint=NULL, center=FALSE, nRepeats=5, seed=NULL, randomize=TRUE, 
    blocks=1, block.name="Blocks", wholeBlockData=NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nruns}{ number of runs in the requested design }
   \item{data}{ data frame or matrix of candidate design points;\cr
        if \code{data} is specified, \code{factor.names} and \code{levels} are ignored}
   \item{formula}{ a model formula (starting with a tilde), 
        for the estimation of which a D-optimal design is sought;\cr
        it can contain all column names from \code{data} 
        or elements or element names from \code{factor.names}, respectively;\cr
        usage of the \dQuote{.}-notation for \dQuote{all variables} from \code{data} or \code{factor.names} 
        is possible. \cr
        The default formula linearly includes all main effects for columns of \code{data} or factors from 
        \code{factor.names} respectively, by using the \dQuote{.}-notation. 
        Note that the variables from \code{wholeBlockData} must be explicitly included into the formula 
        and are not covered by the \dQuote{.}-notation for \dQuote{all variables}. (Thus, the default formula 
        does not work, if \code{wholeBlockData} is used.)
        For quantitative factors, functions \code{quad()} and \code{cubic} describe the 
        full quadratic or full cubic model in the listed variables (cf. examples 
        and the \code{\link[AlgDesign]{expand.formula}}-function from package \pkg{AlgDesign}).  
        }
  \item{factor.names}{ is used for creating a candidate set (for the within Block factors) 
        with the help of function 
        \code{\link[DoE.base]{fac.design}}, if \code{data} is not specified. It is a 
        list of vectors which contain\cr
        - individual levels\cr
        - or (in case of numerical values combined with nlevels) lower and upper scale end values \cr
        for each factor.\cr
        The element names are used as variable names; \cr
        if the list is not named, the variable names are A, B and so forth (from function 
        \code{\link[DoE.base]{fac.design}}).\cr
        \code{factor.names} can also be a character vector. 
        In this case, \code{nlevels} must be specified, and levels are automatically assigned 
        as integers starting with 1.
        }
  \item{nlevels}{ can be omitted if the list \code{factor.names} explicitly 
        lists all factor levels (which of course defines the number of levels).\cr 
        For numeric factors for which \code{factor.names} only specifies the 
        two scale ends, these are filled with equally-spaced intermediate points, 
        using the nlevels entry as the \code{length.out} argument to function 
        \code{\link{seq}}.\cr 
        If \code{factor.names} is a character vector of factor names only, 
        \code{nlevels} is required, and default levels are created. 
        }
  \item{digits}{ is used for creating a candidate set if \code{data} is not specified.\cr 
        It specifies the digits to which numeric design columns are rounded in case of 
        automatic creation of intermediate values. It can consist of one single value 
        (the same for all such factors) or a numeric vector of the same length 
        as \code{factor.names} with integer entries.
        }
  \item{constraint}{ a condition (character string!) used for reducing the candidate 
        set to admissible points only. 
        \code{constraint} is evaluated on the specified data set or after automatic creation 
        of a full factorial candidate data set. \cr 
        The variable names from \code{data} or \code{factor.names} can be used by the constraint.
        The variable names from \code{wholePlotData} can NOT be used. \cr
        See \code{\link[base]{Syntax}} and \code{\link[base]{Logic}} 
        for an explanation of the syntax of general and especially logical 
        R expressions.
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
  \item{blocks}{ a single integer giving the number of blocks (default 1, if no blocking is needed)\cr 
        OR\cr
        a vector of block sizes which enable blocks of different sizes;\cr 
        for a scalar value, \code{nruns} must be divisible into blocks equally-sized blocks; 
        for a vector value, the block sizes must add up to \code{nruns}.\cr
        If blocking is requested, the following two options are potentially important.}
  \item{block.name}{ character string: name of the blocking variable (used only if blocks are requested) }
  \item{wholeBlockData}{ optional matrix or data frame that specifies the whole block characteristics;\cr 
        can only be used if blocks are requested; if used, it must have as many rows as there are block sizes.\cr
        If this is specified, the resulting design is a split-plot design with the whole-plot 
        factors specified in wholeBlockData, the split-plot factors specified in data. 
        Note that usage of this option makes it necessary to explicitly specify a formula.\cr
        
        Since wholeBlockData must be completely specified by the user, optimization is 
        for the split-plot portion of the design only. The rationale is (assumably) that the 
        characteristics of the available blocks are known. If this is not the case, users 
        may want to try out various possible whole block setups, or to proceed sequentially 
        by first optimizing a whole block design for a model with the whole block factors only 
        and subsequently using this model for adding split-plot factors.}
  \item{\dots}{ additional arguments to functions \code{\link[AlgDesign]{optFederov}} 
        or \code{\link[AlgDesign]{optBlock}} (if blocking is requested) 
        from package \pkg{AlgDesign};\cr 
        interesting arguments for \code{optFederov}: \code{maxIteration}, 
        \code{nullify} (calculate good starting design, especially set to 1, 
        in which case \code{nRepeats} is set to 1);\cr 
        arguments \code{criterion} and \code{augment} are not available, neither 
        are \code{evaluateI}, \code{space}, or \code{rows}, and \code{args} 
        does not have an effect. }
}
\details{
   Function \code{Dopt.design} creates a D-optimal design, optionally with blocking, 
   and even as a split-plot design. If no blocks are required, calculations are carried 
   out through function \code{\link[AlgDesign]{optFederov}} from package \pkg{AlgDesign}. 
   In case of blocked designs, function \code{\link[AlgDesign]{optBlock}} from package \pkg{AlgDesign} 
   is behind the calculations. By specifying \code{wholeBlockData}, a blocked design becomes 
   a split-plot design. The model formula can refer to both the within block data (only those 
   are referred to by the \dQuote{.} notation) and the whole block data and interactions between both. \cr
   In comparison to direct usage of package \pkg{AlgDesign}, the function adds the possibility 
   of automatically creating the candidate points on the fly, with or without constraints.
   Furthermore, it embeds the D-optimal designs into the class \code{\link[DoE.base:class-design]{design}}. 
   On the other hand, it sacrifices some of \pkg{AlgDesign}s flexibility; of course, users 
   can still use \pkg{AlgDesign} directly. \cr
   
   The D-optimal designs are particularly useful, if the classical regular designs are too demanding 
   in run size requirements, or if constraints preclude automatic generation of orthogonal designs. 
   Note, however, that the best design in few runs can still be very bad in absolute terms!
   
   When specifying the design without the \code{data} option, a full factorial in the 
   requested factors is the default candidate set of design points. For some situations - especially 
   with many factors - it may be better to start from a restricted candidate set. Such a candidate set 
   can be produced with another R function, e.g. \code{\link[DoE.base]{oa.design}} or \code{\link[FrF2]{FrF2}}, 
   or can be manually created. 
      
   If there are doubts, whether the process has delivered a design close to the absolute optimum, 
   \code{nRepeats} can be increased.
   
   For unblocked designs, it is additionally possible to increase \code{maxIteration}. 
   Also, improving the starting 
   value by \code{nullify=1} or \code{nullify=2} may lead to an improved design. 
   These options are handed through to function \code{\link[AlgDesign]{optFederov}} 
   from package \pkg{AlgDesign} and are documented there.
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

    The attribute \code{design.info} is a list of various design properties, with type resolving to \dQuote{Dopt}, 
    \dQuote{Dopt.blocked}, \dQuote{Dopt.splitplot}. 
    In addition to the standard list elements (cf. \code{\link[DoE.base:class-design]{design}}), the element 
    \code{quantitative} is a vector of \code{nfactor} logical values or NAs, 
    and the optional \code{digits} elements indicates the number of digits to 
    which the data were rounded. 
    For blocked and splitplot designs, the list contains additional information on numbers and sizes of blocks or plots, 
    as well as the number of whole plot factors (which are always the first few factors) and split-plot factors.\cr
    The list contains a list of optimality criteria as calculated by function \code{\link[AlgDesign]{optFederov}}, 
    see documentation there) 
    with elements \code{D}, \code{Dea}, \code{A} and \code{G}. 
    
    (Note that \code{replications} is always 1 and \code{repeat.only} is always FALSE; 
    these elements are only present to fulfill the formal requirements for class \code{design}.
    Note however, that blocked designs do in fact repeat experimental runs if \code{nruns} and \code{blocks}
    imply this.)
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
   plan
   cor(plan)
   y <- rnorm(36)
   r.plan <- add.response(plan, y)
   plan2 <- Dopt.augment(r.plan, m=10)
   plot(plan2)
   cor(plan2)
   
   ## designs with qualitative factors and blocks for
   ## an experiment on assessing stories of social situations
   ## where each subject is a block and receives a deck of 5 stories
   plan.v <- Dopt.design(480, factor.names=list(cause=c("sick","bad luck","fault"), 
             consequences=c("alone","children","sick spouse"),
             gender=c("Female","Male"),
             Age=c("young","medium","old")),
             blocks=96,
             constraint="!(Age==\"young\" & consequences==\"children\")",
             formula=~.+cause:consequences+gender:consequences+Age:cause)
   ## an experiment on assessing stories of social situations
   ## with the whole block (=whole plot) factor gender of the assessor
   ##    not run for saving test time on CRAN
   \dontrun{plan.v.splitplot <- Dopt.design(480, factor.names=list(cause=c("sick","bad luck","fault"), 
             consequences=c("alone","children","sick spouse"),
             gender.story=c("Female","Male"),
             Age=c("young","medium","old")),
             blocks=96,
             wholeBlockData=cbind(gender=rep(c("Female","Male"),each=48)),
             constraint="!(Age==\"young\" & consequences==\"children\")",
             formula=~.+gender+cause:consequences+gender.story:consequences+
                 gender:consequences+Age:cause+gender:gender.story)}
}
\seealso{ See also \code{\link[AlgDesign]{optFederov}}, \code{\link[DoE.base]{fac.design}}, 
    \code{\link[AlgDesign:expand.formula]{quad}}, \code{\link[AlgDesign:expand.formula]{cubic}},
    \code{\link{Dopt.augment}} }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }
\keyword{ design }% __ONLY ONE__ keyword per line
