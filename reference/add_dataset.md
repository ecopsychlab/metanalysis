# Add a list of R objects to an existing meta_study object.

Add a list of R objects to an existing meta_study object.

## Usage

``` r
add_dataset(
  x,
  dataset_name,
  data_type = NULL,
  engine = arrow::write_parquet,
  engine_args = NULL,
  file_ext = NULL
)
```

## Arguments

- x:

  `Named list` of objects to create an arrow-compatible data set from.

- dataset_name:

  `Character scalar`. Name of the database folder that should be
  created.

- data_type, file_ext:

  `Character scalar`. Specify file suffix and file extension,
  respectively. (Default: `NULL`)

- engine:

  `function` The function that will write out the content of `x`.
  (Default:
  [`arrow::write_parquet`](https://arrow.apache.org/docs/r/reference/write_parquet.html))

- engine_args:

  `list` of other arguments to `engine` function argument. (Default:
  NULL)
