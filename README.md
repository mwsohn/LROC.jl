# LROC.jl
 
 Provides functions for computing the Area under ROC Curves for logistic regressions using the ROCAnalysis package. 


 ## Installation
 ```
 Pkg.add("LROC.jl")
```

 ## Functions

 - rocinput - Creates target and nontarget vectors from logistic regression output suitable for input to ROCAnalysis.roc function

 - lroc - Produces an AUC value and optionally plots the ROC curves using Plots.jl

 - rocplot - Produces an ROC Curve plot using Plots.jl. `plot(::Roc)` can also be used to create the same plot. `Roc` data type is defined in the ROCAnalysis package

 - roccomp - Compares two ROC Curves from two logistic regressions using the delong_test function defined in ROCAnalysis package



