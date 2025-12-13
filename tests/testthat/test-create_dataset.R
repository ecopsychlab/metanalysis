x <- split.data.frame(mtcars, rep(LETTERS[seq_len(4)], each = 8))


test_that("Adding to dataset is equivalent to including from start", {

    tmp_1 <- withr::local_tempdir()
    tmp_2 <- withr::local_tempdir()
    create_dataset(names(x), tmp_1)
    add_dataset(x, tmp_1)
    create_dataset(x, tmp_2)
    expect_identical(
        list.files(tmp_1, recursive = TRUE),
        list.files(tmp_2, recursive = TRUE)
        )

  })
