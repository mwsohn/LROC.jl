## runtests.jl  Unit tests for ROC
## (c) 2014--2015 David A. van Leeuwen
##
## Licensed under the MIT software license, see LICENSE.md

using DataFrames
using ROCAnalysis
using CSV
using GLM
using CategoricalArrays
using Test
using Lroc

df = CSV.read("test\\framingham_heart_disease.csv", DataFrame, missingstring = "NA");

df = df[completecases(df), :];

# Number of observations:         3656
# Number of variables:              16
# ────────┬───────────────────────────────────────────────────
#  Column │ Variable         Eltype   % Miss  Description     
# ────────┼───────────────────────────────────────────────────
#       1 │ male             Int64      0.0%  male
#       2 │ age              Int64      0.0%  age
#       3 │ education        Int64      0.0%  education
#       4 │ currentSmoker    Int64      0.0%  currentSmoker
#       5 │ cigsPerDay       Int64      0.0%  cigsPerDay
#       6 │ BPMeds           Int64      0.0%  BPMeds
#       7 │ prevalentStroke  Int64      0.0%  prevalentStroke
#       8 │ prevalentHyp     Int64      0.0%  prevalentHyp
#       9 │ diabetes         Int64      0.0%  diabetes
#      10 │ totChol          Int64      0.0%  totChol
#      11 │ sysBP            Float64    0.0%  sysBP
#      12 │ diaBP            Float64    0.0%  diaBP
#      13 │ BMI              Float64    0.0%  BMI
#      14 │ heartRate        Int64      0.0%  heartRate
#      15 │ glucose          Int64      0.0%  glucose
#      16 │ TenYearCHD       Int64      0.0%  TenYearCHD
# ────────┴───────────────────────────────────────────────────

df.education = categorical(df.education) ;

logit1 = fit(GeneralizedLinearModel, @formula(TenYearCHD ~ age + male + education + sysBP + diaBP + BMI), df, Bernoulli(), LogitLink());
logit2 = fit(GeneralizedLinearModel, @formula(TenYearCHD ~ age + male + education + sysBP + diaBP + BMI + sysBP + diaBP + BPMeds), df, Bernoulli(), LogitLink());

@test lroc(logit1, rocplot = false) ≈ 0.7286 atol = 0.001
@test lroc(logit1, rocplot = false) ≈ 0.7290 atol = 0.001
@test roccomp(logit1, logit2) ≈ 0.4445 atol = 0.001







