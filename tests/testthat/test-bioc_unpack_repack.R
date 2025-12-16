test_that("Re-assembly does not affect SE content", {
    require("airway")
    data("airway", package="airway")

    path <- tempfile()
    x <- airway

    disassemble_SE(x, path)

    y <- assemble_SE(path)

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
