x <- tempdir(check = FALSE)

random_meta_study(10, x)

test_that("meta_study(meta_study) returns itself unchanged", {
    expect_equal(meta_study(x), meta_study(meta_study(x)))
})
