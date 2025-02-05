test_that("normalize_SE works as expected", {
  # Set up. 
  conc <- rep(seq(0.1, 0.3, 0.1), 2)
  ctrl_df <- S4Vectors::DataFrame(Barcode = c(1, 2),
                                  CorrectedReadout = c(rep(1, 2),
                                                       rep(6, 2)),
                                  control_type = c(rep("UntrtReadout", 2),
                                                   rep("Day0Readout", 2)),
                                  isDay0 = c(rep(FALSE, 2),
                                             rep(TRUE, 2)))
  
  trt_df <- S4Vectors::DataFrame(CorrectedReadout = rep(seq(1, 3, 1), 2),
                                 Concentration = conc,
                                 Barcode = rep(c(1, 2), each = 3),
                                 masked = rep(FALSE, 6))

  coldata <- S4Vectors::DataFrame(CellLineName = "Mickey Mouse",
                                  ReferenceDivisionTime = 1)
  rowdata <- S4Vectors::DataFrame(Duration = 2)

  ctrl <- BumpyMatrix::splitAsBumpyMatrix(row = 1, column = 1, x = ctrl_df)
  trted <- BumpyMatrix::splitAsBumpyMatrix(row = 1, column = 1, x = trt_df)
  
  keys <- list("nested_keys" = "Barcode", 
               "Trt" = "Concentration")
  
  metadata <- list(identifiers = list("cellline_name" = "CellLineName", 
                                      "cellline_ref_div_time" = "ReferenceDivisionTime", 
                                      "duration" = "Duration", 
                                      "masked_tag" = "masked",
                                      "barcode" = "Barcode",
                                      "concentration" = "Concentration",
                                      "concentration2" = "Concentration2"),
                   Keys = keys)
  
  se <- SummarizedExperiment::SummarizedExperiment(assays = list("RawTreated" = trted, "Controls" = ctrl), 
                                                   colData = coldata, 
                                                   rowData = rowdata,
                                                   metadata = metadata)


  se <- normalize_SE(se, data_type = "single-agent")
  normalized <- SummarizedExperiment::assays(se)[["Normalized"]][1, 1][[1]]

  expect_true(methods::is(normalized, "DataFrame"))
  expect_equal(dim(normalized), c(12, 4))
  expect_true(all(colnames(normalized) %in% c("Concentration", "masked", "normalization_type", "x")))
  expect_equal(unique(normalized$Concentration), unique(conc))
  
  se2 <- normalize_SE(se, "single-agent", nested_confounders = 
                        c(gDRutils::get_SE_identifiers(se, "barcode", simplify = TRUE), "masked"))
  expect_s4_class(se2, "SummarizedExperiment")
})
