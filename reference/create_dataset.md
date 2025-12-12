# Create a data set from a list of objects.

Meant to be seamlessly compatible with
[`arrow::read_parquet()`](https://arrow.apache.org/docs/r/reference/read_parquet.html).

## Usage

``` r
create_dataset(
  x,
  dataset_name,
  engine = arrow::write_parquet,
  ...,
  .file_suffix = NULL,
  .file_ext = NULL
)
```

## Arguments

- x:

  `Named list` of objects to create an arrow-compatible dataset from

- dataset_name:

  `Character scalar`. Name of the database folder that should be
  created.

- engine:

  `function` The function that will write out the content of `x`.
  (Default:
  [`arrow::write_parquet`](https://arrow.apache.org/docs/r/reference/write_parquet.html))

- ...:

  Additional arguments to function specified with 'engine' argument.

- .file_suffix, .file_ext:

  `Character scalar`. Specify file suffix and file extension,
  respectively. (Default: `NULL`)
