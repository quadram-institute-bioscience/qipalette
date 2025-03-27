#' Scale color for ggplot2
#'
#' A color scale for ggplot2 based on the package palettes
#'
#' @param palette Character name of the palette
#' @param discrete Logical. Is the scale discrete or continuous?
#' @param reverse Logical. Should the palette be reversed?
#' @param ... Additional arguments passed to discrete_scale() or scale_color_gradientn()
#'
#' @return A ggplot2 scale
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
#'   geom_point(size = 4) +
#'   scale_color_palette("sunset")
#' }
scale_color_palette <- function(palette = "sunset", discrete = TRUE, reverse = FALSE, ...) {
  pal <- get_palette(palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("palette_", palette),
                            palette = function(n) {
                              get_palette(palette, n, reverse)
                            }, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal, ...)
  }
}

#' Scale fill for ggplot2
#'
#' A fill scale for ggplot2 based on the package palettes
#'
#' @param palette Character name of the palette
#' @param discrete Logical. Is the scale discrete or continuous?
#' @param reverse Logical. Should the palette be reversed?
#' @param ... Additional arguments passed to discrete_scale() or scale_fill_gradientn()
#'
#' @return A ggplot2 scale
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
#'   geom_bar() +
#'   scale_fill_palette("qicolors", guide = "none")
#' }
scale_fill_palette <- function(palette = "sunset", discrete = TRUE, reverse = FALSE, ...) {
  pal <- get_palette(palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("palette_", palette),
                            palette = function(n) {
                              get_palette(palette, n, reverse)
                            }, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal, ...)
  }
}
