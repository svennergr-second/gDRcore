test_that("combo_2dose_nonoise: test_synthetic_data", {
  data <- "finalMAE_combo_2dose_nonoise.RDS"
  original <- gDRutils::get_synthetic_data(data)
  
  set.seed(2)
  mae <- purrr::quietly(generateComboNoNoiseData)(
    cell_lines, drugs, FALSE
  )
  expect_length(mae$warnings, 4)
  
  test_synthetic_data(original, mae$result, data)
})
