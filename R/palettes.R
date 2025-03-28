#' Color Palettes
#'
#' A collection of color palettes for data visualization
#'
#' @examples
#' # View all palettes
#' display_all_palettes()
#'
#' # Use a specific palette
#' pal <- get_palette("sunset", n = 5)
#' plot(1:5, 1:5, col = pal, pch = 19, cex = 3)
#'
#' @name qipalette-package
NULL

#' Available color palettes
#'
#' A list containing all available color palettes
#'
#' @export
palettes <- list(
  # Define your color palettes here
  qicolors = c("#009681", "#B5BD00", "#333F48", "#CF4520", "#48A23F", "#FF9E1B", "#00778B"),
  blues    = c("#333F48", "#225C5B", "#11796E", "#009681", "#2BA896", "#55B9AB", "#AADCD5"),
  forest   = c("#eeeeee", "#b3eee4", "#00e6c5", "#009681", "#3CA356", "#79B02B", "#B5BD00"),
  sunset   = c("#fff1df", "#ffd69f", "#ffbb60", "#ffa020", "#df8000", "#9f5c00", "#603700", "#201200")

)

#' Get a color palette
#'
#' Returns a vector of colors from a specified palette
#'
#' @param name Character name of the palette
#' @param n Number of colors desired. If provided, the palette will be interpolated
#'   to produce the desired number of colors.
#' @param reverse Logical. Should the palette be reversed?
#'
#' @return A character vector of colors
#' @export
#'
#' @examples
#' get_palette("sunset", 3)
#' get_palette("qicolors", 10)
#' get_palette("forest", 5, reverse = TRUE)
get_palette <- function(name, n = NULL, reverse = FALSE) {
  pal <- palettes[[name]]

  if(is.null(pal))
    stop("Palette not found. Available palettes: ", paste(names(palettes), collapse = ", "))

  if(!is.null(n)) {
    if(n <= length(pal)) {
      pal <- pal[seq_len(n)]
    } else {
      pal <- grDevices::colorRampPalette(pal)(n)
    }
  }

  if(reverse) pal <- rev(pal)

  return(pal)
}

#' Display a color palette
#'
#' Creates a simple plot displaying the colors in a palette
#'
#' @param name Character name of the palette
#' @param n Number of colors to display
#'
#' @return A plot (invisible NULL)
#' @export
#' @importFrom graphics par plot title rect
#'
#' @examples
#' display_palette("sunset")
#' display_palette("qicolors", 10)
display_palette <- function(name, n = NULL) {
  pal <- get_palette(name, n)
  n <- length(pal)

  old_par <- par(mar = c(0, 0, 2, 0))
  on.exit(par(old_par))

  plot(0, 0, type = "n", xlim = c(0, 1), ylim = c(0, 1), axes = FALSE, xlab = "", ylab = "")
  title(main = name)

  rect_width <- 1 / n

  for(i in 1:n) {
    rect(rect_width * (i - 1), 0, rect_width * i, 1, col = pal[i], border = NA)
  }

  invisible(NULL)
}

#' Display all available palettes
#'
#' Creates a multi-panel plot showing all available palettes
#'
#' @param n Number of colors to display for each palette
#'
#' @return A plot (invisible NULL)
#' @export
#' @importFrom graphics par
#'
#' @examples
#' display_all_palettes()
#' display_all_palettes(10)
display_all_palettes <- function(n = NULL) {
  pal_names <- names(palettes)
  n_pals <- length(pal_names)

  old_par <- par(mfrow = c(n_pals, 1), mar = c(0, 0, 1, 0))
  on.exit(par(old_par))

  for(name in pal_names) {
    display_palette(name, n)
  }

  invisible(NULL)
}

#' Apply palette to a plot
#'
#' Helper function to quickly apply a palette to common plotting functions
#'
#' @param name Character name of the palette
#' @param n Number of colors needed (typically matches the number of groups)
#' @param reverse Logical. Should the palette be reversed?
#'
#' @return A function that can be used with the col parameter in plotting functions
#' @export
#'
#' @examples
#' \dontrun{
#' # For base R plots
#' plot(mpg ~ disp, data = mtcars, col = palette_color("sunset")(factor(mtcars$cyl)))
#'
#' # For ggplot2 (after setting up scale_color_palette or scale_fill_palette)
#' library(ggplot2)
#' ggplot(mtcars, aes(mpg, disp, color = factor(cyl))) +
#'   geom_point() +
#'   scale_color_manual(values = palette_color("sunset")(3))
#' }
palette_color <- function(name, n = NULL, reverse = FALSE) {
  function(x) {
    if(is.factor(x)) {
      x_levels <- levels(x)
      n_colors <- length(x_levels)
      pal <- get_palette(name, n_colors, reverse)
      return(pal[as.integer(x)])
    } else if(is.numeric(x)) {
      n_colors <- n %||% 10  # Default to 10 colors if n is NULL
      pal <- get_palette(name, n_colors, reverse)
      # Map x to integers between 1 and n_colors
      bins <- cut(x, breaks = n_colors, labels = FALSE, include.lowest = TRUE)
      return(pal[bins])
    } else {
      n_colors <- n %||% length(unique(x))
      pal <- get_palette(name, n_colors, reverse)
      return(pal[as.integer(factor(x))])
    }
  }
}

# Helper function for NULL handling
`%||%` <- function(a, b) if(is.null(a)) b else a
