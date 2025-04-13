# LogisticROC.jl
 
 Provides functions for computing the Area under ROC Curves for logistic regressions using the `ROCAnalysis` package. 


 ## Installation
 ```
julia> using Pkg
julia> Pkg.add("LogisticROC")
```

 ## Functions

 - rocinput - Creates target and nontarget vectors from logistic regression output suitable for input to ROCAnalysis.roc function

 - lroc - Produces an AUC value and optionally plots the ROC curves using Plots.jl

 - rocplot - Produces an ROC Curve plot using Plots.jl. `plot(::Roc)` can also be used to create the same plot. `Roc` data type is defined in the ROCAnalysis package

 - roccomp - Compares two ROC Curves from two logistic regressions using the delong_test function defined in ROCAnalysis package

## Examples

```
# import packages to use in this tutorial
using CSV, DataFrames, GLM, LogisticROC

# download data and convert it to a DataFrame. We will treat all "NA" values as missing.
df = CSV.read("test/framingham_heart_disease.csv",DataFrame, missingstring = "NA");

# drop records with missing values
df = df[completecases(df),:];

# make education a CategoricalArray. It is an ordinal variable with four levels
df.education = categorical(df.education);

# estimate two logistic regression models
# Model 1
logit1 = glm(@formula(TenYearCHD ~ age + male + education + sysBP + diaBP + BMI), fram2, Bernoulli(), LogitLink());

StatsModels.TableRegressionModel{GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Bernoulli{Float64}, LogitLink}, GLM.DensePredChol{Float64, LinearAlgebra.CholeskyPivoted{Float64, Matrix{Float64}, Vector{Int64}}}}, Matrix{Float64}}  

TenYearCHD ~ 1 + age + male + education + sysBP + diaBP + BMI

Coefficients:
────────────────────────────────────────────────────────────────────────────────
                    Coef.  Std. Error       z  Pr(>|z|)   Lower 95%    Upper 95%
────────────────────────────────────────────────────────────────────────────────
(Intercept)   -7.57454     0.506306    -14.96    <1e-49  -8.56689    -6.5822
age            0.0596155   0.00639597    9.32    <1e-19   0.0470796   0.0721513
male           0.682277    0.100539      6.79    <1e-10   0.485224    0.87933
education: 2  -0.166788    0.121905     -1.37    0.1713  -0.405717    0.0721414
education: 3  -0.174504    0.147897     -1.18    0.2380  -0.464377    0.11537
education: 4  -0.071857    0.162861     -0.44    0.6591  -0.391058    0.247344
sysBP          0.0204319   0.00343044    5.96    <1e-08   0.0137084   0.0271554
diaBP         -0.00504329  0.00629717   -0.80    0.4232  -0.0173855   0.00729894
BMI            0.00635771  0.0124658     0.51    0.6100  -0.0180748   0.0307902
──────────────────────────────────────────────────────────────────────────────── 

# Model 2
logit2 = glm(@formula(TenYearCHD ~ age + male + education + sysBP + diaBP + BMI + sysBP + diaBP +BPMeds), fram2, Bernoulli(), LogitLink());

StatsModels.TableRegressionModel{GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Bernoulli{Float64}, LogitLink}, GLM.DensePredChol{Float64, LinearAlgebra.CholeskyPivoted{Float64, Matrix{Float64}, Vector{Int64}}}}, Matrix{Float64}}

TenYearCHD ~ 1 + age + male + education + sysBP + diaBP + BMI + BPMeds

Coefficients:
────────────────────────────────────────────────────────────────────────────────
                    Coef.  Std. Error       z  Pr(>|z|)   Lower 95%    Upper 95%
────────────────────────────────────────────────────────────────────────────────
(Intercept)   -7.48096     0.512877    -14.59    <1e-47  -8.48618    -6.47574
age            0.0593918   0.00639899    9.28    <1e-19   0.04685     0.0719335
male           0.686982    0.100702      6.82    <1e-11   0.48961     0.884354
education: 2  -0.170715    0.122016     -1.40    0.1618  -0.409861    0.068431
education: 3  -0.175562    0.147971     -1.19    0.2354  -0.46558     0.114456
education: 4  -0.0769528   0.16292      -0.47    0.6367  -0.39627     0.242364
sysBP          0.0197647   0.00348217    5.68    <1e-07   0.0129397   0.0265896
diaBP         -0.00491749  0.006301     -0.78    0.4351  -0.0172672   0.00743225
BMI            0.00588079  0.0124819     0.47    0.6375  -0.0185832   0.0303448
BPMeds         0.26075     0.229636      1.14    0.2562  -0.189329    0.710829
──────────────────────────────────────────────────────────────────────────────── 


# Area under the ROC Curve (AUC) value and the ROC plot
# Model 1
lroc(logit1)


Number of observations = 3656.0
Area under ROC curve   = 0.728567679502799


# Model 2
lroc(logit1)

Number of observations = 3656.0
Area under ROC curve   = 0.7290485203137862


# ROC Curves for the two logistic regression models can be compared
roccomp(logit1, logit2)

0.44452118332095947

# This is the p-value under H₀: AUC for Model 1 = AUC for Model 2

# ROC curves can be drawn with rocplot
plt = rocplot(logit1)

# To edit the plot, save the return value and use it to edit the plot:


```

