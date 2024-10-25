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

## Examples

```
# import packages to use in this tutorial
using CSV, DataFrames, GLM

# download data and convert it to a DataFrame
df = CSV.read("test/framingham_heart_disease.csv",DataFrame);

# make education a CategoricalArray. It is an ordinal variable with four levels
df.education = categorical(df.education)

# estimate two logistic regression models
# Model 1
logit1 = glm(@formula(TenYearCHD ~ age + male + education + sysBP + diaBP + BMI), fram2, Bernoulli(), LogitLink());

# Model 2
logit2 = glm(@formula(TenYearCHD ~ age + male + education + sysBP + diaBP + BMI + sysBP + diaBP +BPMeds), fram2, Bernoulli(), LogitLink());

# Area under the ROC Curve value and the ROC plot
# Model 1
lroc(logit1)

# Model 2
lroc(logit1)

```









```

