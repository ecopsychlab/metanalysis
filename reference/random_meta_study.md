# Randomly generate a meta_study and corresponding folders.

Mostly for instructive and debugging purposes.

## Usage

``` r
random_meta_study(n, dataset_name = tempdir())
```

## Arguments

- n:

  `Numeric scalar` number of studies to generate

- dataset_name:

  `Character scalar`. Name of the database folder that should be
  created.

## Examples

``` r
x <- random_meta_study(n = 100)
x
#> <metanalysis::meta_study>
#> Error in data.frame(folder_name = self@folder_name, study_name = self@study_names,     study_data = list.files(file.path(self@folder_name, self@study_names),         full.names = FALSE)): arguments imply differing number of rows: 1, 104, 106
```
