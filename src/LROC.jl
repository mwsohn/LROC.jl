module LROC

################################################################################
##
## Dependencies
##
################################################################################

using ROCAnalysis, Plots, GLM

##############################################################################
##
## Exported methods and types (in addition to everything reexported above)
##
##############################################################################

export rocinput,    # creates target and nontarget vectors from logistic regression output suitable for input to ROCAnalysis.roc
    lroc,            # outputs AUC value and optionally plot the ROC curves using Plots.jl
    rocplot,        # produces ROC curve plot using Plots.jl
    roccomp         # compares two ROC Curves from two logistic regressions using ROCAnalysis.delong_test


##############################################################################
##
## Load files
##
##############################################################################
include("main.jl")

end

