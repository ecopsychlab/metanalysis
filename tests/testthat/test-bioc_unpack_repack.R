test_that("Packing does not affect SE content", {

    data("airway", package="airway")

    path <- tempdir()
    x <- airway

    unpack_SE(x, path)

    y <- repack_SE(path)

    expect_identical(
        colData(x), colData(y)
    )

    expect_identical(
        rowData(x), rowData(y)
    )

    expect_identical(
        as.data.frame(assays(x)), as.data.frame(assays(y))
    )

    expect_identical(
        dimnames(x),  dimnames(y)
    )

    })
