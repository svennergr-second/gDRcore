test_that("small: test_synthetic_data", {
  data <- "finalMAE_small.RDS"
  original <- gDRutils::get_synthetic_data(data)
  
  set.seed(2)
  mae <- purrr::quietly(generateNoiseRawData)(
    cell_lines, drugs, FALSE
  )
  expect_length(mae$warnings, 3)
  
  test_synthetic_data(original, mae$result, data)
})
