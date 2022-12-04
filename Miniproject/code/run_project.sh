#!/bin/bash

Rscript DataHandling.R

Rscript poly_models_fit.R

Rscript logistic_models_fit.R

Rscript gompertz_models_fit.R

Rscript model_analysis_plot.R

bash CompileLatex.sh main.tex

rm *.pdf
