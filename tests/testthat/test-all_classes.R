test_that("meta_study(meta_study) returns itself unchanged", {

    xx <- tempdir(check = FALSE)

    random_meta_study(10, xx)

    expect_equal(meta_study(xx), meta_study(meta_study(xx)))
})
