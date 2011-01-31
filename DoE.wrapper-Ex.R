pkgname <- "DoE.wrapper"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('DoE.wrapper')

assign(".oldSearch", search(), pos = 'CheckExEnv')
cleanEx()
nameEx("Dopt.augment")
### * Dopt.augment

flush(stderr()); flush(stdout())

### Name: Dopt.augment
### Title: Function for augmenting a design with D-optimal additional
###   points using optFederov from package AlgDesign
### Aliases: Dopt.augment
### Keywords: array design

### ** Examples

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
   ## add the new response values after conducting additional experiments
   y <- c(y, rnorm(10))
   r.plan2 <- add.response(plan2,y, replace=TRUE)
   summary(r.plan2, brief=FALSE)
   



cleanEx()
nameEx("Dopt.design")
### * Dopt.design

flush(stderr()); flush(stdout())

### Name: Dopt.design
### Title: Function for creating D-optimal designs with or without blocking
###   from package AlgDesign
### Aliases: Dopt.design
### Keywords: array design

### ** Examples

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
   plan.v.splitplot <- Dopt.design(480, factor.names=list(cause=c("sick","bad luck","fault"), 
             consequences=c("alone","children","sick spouse"),
             gender.story=c("Female","Male"),
             Age=c("young","medium","old")),
             blocks=96,
             wholeBlockData=cbind(gender=rep(c("Female","Male"),each=48)),
             constraint="!(Age==\"young\" & consequences==\"children\")",
             formula=~.+gender+cause:consequences+gender.story:consequences+
                 gender:consequences+Age:cause+gender:gender.story)



cleanEx()
nameEx("bbd.design")
### * bbd.design

flush(stderr()); flush(stdout())

### Name: bbd.design
### Title: Function for generating Box-Behnken designs
### Aliases: bbd.design
### Keywords: array design

### ** Examples

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



cleanEx()
nameEx("ccd.augment")
### * ccd.augment

flush(stderr()); flush(stdout())

### Name: ccd.augment
### Title: Functions for accessing central composite designs from package
###   rsm
### Aliases: ccd.augment
### Keywords: array design

### ** Examples

  ## purely technical examples for the sequential design creation process
    ## start with a fractional factorial with center points
    plan <- FrF2(16,5,default.levels=c(10,30),ncenter=6)
    ## collect data and add them to the design
    y <- rexp(22)
    plan <- add.response(plan,y)
    ## assuming that an analysis has created the suspicion that a second order 
    ## model should be fitted (not to be expected for the above random numbers):
    plan.augmented <- ccd.augment(plan, ncenter=4)
    ## add new responses to the design
    y <- c(y, rexp(14))  ## append responses for the 14=5*2 + 4 star points
    r.plan.augmented <- add.response(plan.augmented, y, replace=TRUE)

  ## for info: how to analyse results from such a desgin
    lm.result <- lm(y~Block.ccd+(.-Block.ccd)^2+I(A^2)+I(B^2)+I(C^2)+I(D^2)+I(E^2), r.plan.augmented)
    summary(lm.result)
    ## analysis with function rsm
    rsm.result <- rsm(y~Block.ccd+SO(A,B,C,D,E), r.plan.augmented)
    summary(rsm.result)  ## provides more information than lm.result
    loftest(rsm.result)  ## separate lack of fit test
    ## graphical analysis 
    ## (NOTE: purely for demo purposes, the model is meaningless here)
    ## individual contour plot
    contour(rsm.result,B~A)
    ## several contour plots
    par(mfrow=c(1,2))
    contour(rsm.result,list(B~A, C~E))
    ## many contourplots, all pairs of some factors
    par(mfrow=c(2,3))
    contour(rsm.result,~A+B+C+D)



graphics::par(get("par.postscript", pos = 'CheckExEnv'))
cleanEx()
nameEx("ccd.design")
### * ccd.design

flush(stderr()); flush(stdout())

### Name: ccd.design
### Title: Functions for accessing central composite designs from package
###   rsm
### Aliases: ccd.design
### Keywords: array design

### ** Examples

ccd.design(5) ## per default uses the resolution V design in 16 runs for the cube
ccd.design(5, ncube=32) ## uses the full factorial for the cube
ccd.design(5, ncenter=6, default.levels=c(-10,10))
## blocked design (requires ncube to be specified)
ccd.design(5, ncube=32, blocks=4) 
## there is only one star point block

## for usage of other options, look at the FrF2 documentation



cleanEx()
nameEx("lhs.design")
### * lhs.design

flush(stderr()); flush(stdout())

### Name: lhs.design
### Title: Functions for accessing latin hypercube sampling designs from
###   package lhs or space-filling designs from package DiceDesign
### Aliases: lhs.design lhs.augment
### Keywords: array design

### ** Examples

   ## maximin design from package lhs
   plan <- lhs.design(20,7,"maximin",digits=2) 
   plan
   plot(plan)
   cor(plan)
   y <- rnorm(20)
   r.plan <- add.response(plan, y)
   
   ## augmenting the design with 10 additional points, default method
   plan2 <- lhs.augment(plan, m=10)
   plot(plan2)
   cor(plan2)
   
   ## purely random design (usually not ideal)
   plan3 <- lhs.design(20,4,"random",
          factor.names=list(c(15,25), c(10,90), c(0,120), c(12,24)), digits=2)
   plot(plan3)
   cor(plan3)
   
   ## optimum design from package lhs (default)
   plan4 <- lhs.design(20,4,"optimum",
        factor.names=list(torque=c(10,14),friction=c(25,35),
              temperature=c(-5,35),pressure=c(20,50)),digits=2)
   plot(plan4)
   cor(plan4)
   
   ## dmax design from package DiceDesign
   ## arguments range and niter_max are required
   ## ?dmaxDesign for more info
   plan5 <- lhs.design(20,4,"dmax",
        factor.names=list(torque=c(10,14),friction=c(25,35),
              temperature=c(-5,35),pressure=c(20,50)),digits=2,
              range=0.2, niter_max=500)
   plot(plan5)
   cor(plan5)
   
   ## Strauss design from package DiceDesign
   ## argument RND is required
   ## ?straussDesign for more info
   plan6 <- lhs.design(20,4,"strauss",
        factor.names=list(torque=c(10,14),friction=c(25,35),
              temperature=c(-5,35),pressure=c(20,50)),digits=2,
              RND = 0.2)
   plot(plan6)
   cor(plan6)
   
   ## full factorial design from package DiceDesign
   ## mini try-out version
   plan7 <- lhs.design(3,4,"fact",
        factor.names=list(torque=c(10,14),friction=c(25,35),
              temperature=c(-5,35),pressure=c(20,50)),digits=2)
   plot(plan7)
   cor(plan7)
   
   ## Not run: 
##D    
##D    ## full factorial design from package DiceDesign
##D    ## not as many different levels as runs, but only a fixed set of levels
##D    ##    caution: too many levels can easily bring down the computer
##D    ##    above design with 7 distinct levels for each factor, 
##D    ##    implying 2401 runs 
##D    plan7 <- lhs.design(7,4,"fact",
##D         factor.names=list(torque=c(10,14),friction=c(25,35),
##D               temperature=c(-5,35),pressure=c(20,50)),digits=2)
##D    plot(plan7)
##D    cor(plan7)
##D    
##D    ## equivalent call
##D    plan7 <- lhs.design(,4,"fact",nlevels=7,
##D         factor.names=list(torque=c(10,14),friction=c(25,35),
##D               temperature=c(-5,35),pressure=c(20,50)),digits=2)
##D    
##D    ## different number of levels for each factor
##D    plan8 <- lhs.design(,4,"fact",nlevels=c(5,6,5,7),
##D         factor.names=list(torque=c(10,14),friction=c(25,35),
##D               temperature=c(-5,35),pressure=c(20,50)),digits=2)
##D    plot(plan8)
##D    cor(plan8)
##D 
##D    ## equivalent call (specifying nruns, not necessary but a good check)
##D    plan8 <- lhs.design(1050,4,"fact",nlevels=c(5,6,5,7),
##D         factor.names=list(torque=c(10,14),friction=c(25,35),
##D               temperature=c(-5,35),pressure=c(20,50)),digits=2)
##D    
## End(Not run)
   


cleanEx()
nameEx("optimality.criteria")
### * optimality.criteria

flush(stderr()); flush(stdout())

### Name: optimality.criteria
### Title: Overview of optimality criteria in experimental design packages
### Aliases: optimality.criteria Scalc compare
### Keywords: array design

### ** Examples

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
   


cleanEx()
nameEx("rsmformula")
### * rsmformula

flush(stderr()); flush(stdout())

### Name: rsmformula
### Title: Functions for supporting response surface analysis with package
###   rsm
### Aliases: rsmformula code.design
### Keywords: array design

### ** Examples

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
   


### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
