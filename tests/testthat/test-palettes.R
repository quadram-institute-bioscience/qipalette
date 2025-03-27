test_that("palettes exist and are properly formatted", {
  expect_type(palettes, "list")
  expect_gt(length(palettes), 0)

  # Check that all palettes are character vectors of colors
  for (pal_name in names(palettes)) {
    pal <- palettes[[pal_name]]
    expect_type(pal, "character")
    expect_gt(length(pal), 0)

    # Check that all colors are valid
    for (color in pal) {
      expect_true(grepl("^#[0-9A-F]{6}$", color, ignore.case = TRUE))
    }
  }
})

test_that("get_palette returns expected output", {
  # Test basic functionality
  sunset_pal <- get_palette("sunset")
  expect_equal(sunset_pal, palettes$sunset)

  # Test n parameter
  sunset_pal_3 <- get_palette("sunset", 3)
  expect_length(sunset_pal_3, 3)

  sunset_pal_10 <- get_palette("sunset", 10)
  expect_length(sunset_pal_10, 10)

  # Test reverse parameter
  sunset_pal_rev <- get_palette("sunset", reverse = TRUE)
  expect_equal(sunset_pal_rev, rev(palettes$sunset))

  # Test error for non-existent palette
  expect_error(get_palette("nonexistent"))
})

test_that("display functions don't error", {
  # These tests just check that the functions run without error
  expect_invisible(display_palette("sunset"))
  expect_invisible(display_palette("qicolors", 7))
  expect_invisible(display_all_palettes())
})

test_that("palette_color function works correctly", {
  # Test with factor
  f <- factor(c("a", "b", "c"))
  colors <- palette_color("sunset")(f)
  expect_length(colors, 3)

  # Test with numeric
  n <- c(1, 2, 3, 4, 5)
  colors <- palette_color("sunset")(n)
  expect_length(colors, 5)
})
