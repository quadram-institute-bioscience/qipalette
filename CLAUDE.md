# qipalette - Guidelines for Claude

## Build and Test Commands
- Build package: `devtools::build()` or `R CMD build`
- Install package: `devtools::install()` or `R CMD INSTALL`
- Run all tests: `devtools::test()` or `testthat::test_package("qipalette")`
- Run single test: `testthat::test_file("tests/testthat/test-palettes.R")`
- Generate documentation: `devtools::document()`

## Code Style Guidelines
- Indentation: 2 spaces (no tabs)
- Naming: camelCase for functions, snake_case for variables
- Line endings: POSIX-style (LF)
- Auto-append newlines to files
- Strip trailing whitespace
- Documentation: Roxygen with markdown formatting
- Test files: Use `test_that()` with descriptive messages and appropriate expectations
- Error handling: Use appropriate error messages with `stop()`
- Always include examples in function documentation
- Verify color formats with regex `^#[0-9A-F]{6}$` (case insensitive)
- Follow R package structure conventions (R/, man/, tests/, vignettes/)