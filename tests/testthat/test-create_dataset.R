x <- split.data.frame(mtcars, rep(LETTERS[seq_len(4)], each = 8))


test_that("Adding to dataset is equivalent to including from start", {

    tmp_base <- withr::local_tempdir()

    tmp_1 <- file.path(tmp_base, "tmp_1")
    tmp_2 <- file.path(tmp_base, "tmp_2")

    create_forest_study(names(x), tmp_1)
    add_to_forest(x, tmp_1)

    x1 <- list.files(tmp_1, recursive = TRUE)

    create_forest_study(x, tmp_2)

    x2 <- list.files(tmp_2, recursive = TRUE)

    expect_identical(  x1, x2   )

  })
