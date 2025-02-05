% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reference_utils.R
\name{create_control_df}
\alias{create_control_df}
\title{Create a control data.table for a treatment-cell line combination.}
\usage{
create_control_df(
  df_,
  control_cols,
  control_mean_fxn = function(x) mean(x, trim = 0.25),
  out_col_name
)
}
\arguments{
\item{df_}{data.table}

\item{control_cols}{character vector of columns to include in the resulting
control data.table.}

\item{control_mean_fxn}{function indicating how to average controls.
Defaults to \code{mean(x, trim = 0.25)}.}

\item{out_col_name}{string of the output readout that will replace
\code{CorrectedReadout}.}
}
\value{
data.table of values aggregated by
}
\description{
Create an aggregated control data.table.
}
