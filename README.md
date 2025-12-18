
<!-- README.md is generated from README.Rmd. Please edit that file -->

# metanalysis

<!-- badges: start -->

[![GitHub
issues](https://img.shields.io/github/issues/ecopsychlab/metanalysis)](https://github.com/ecopsychlab/metanalysis/issues)
[![GitHub
pulls](https://img.shields.io/github/issues-pr/ecopsychlab/metanalysis)](https://github.com/ecopsychlab/metanalysis/pulls)
[![R
BiocCheck](https://github.com/ecopsychlab/metanalysis/actions/workflows/test.yaml/badge.svg)](https://github.com/ecopsychlab/metanalysis/actions/workflows/test.yaml)
<!-- badges: end --> The goal of metanalysis is to provide a convenient
interface to manage and analyse multiple data sets.

## Installation

You can install the development version of metanalysis from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("ecopsychlab/metanalysis")
```

## Imaginary Usecase

This is a basic example which shows you how to solve a common problem:

``` r
library(metanalysis)
# We have a list of tables
x <- split.data.frame(mtcars, rep(LETTERS[seq_len(4)], each = 8))
x
#> $A
#>                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> 
#> $B
#>                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
#> Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
#> Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> 
#> $C
#>                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Chrysler Imperial 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> Fiat 128          32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> Honda Civic       30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> Toyota Corolla    33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
#> Toyota Corona     21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> Dodge Challenger  15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> AMC Javelin       15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> Camaro Z28        13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> 
#> $D
#>                   mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Pontiac Firebird 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> Fiat X1-9        27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> Porsche 914-2    26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> Lotus Europa     30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
#> Ford Pantera L   15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> Ferrari Dino     19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> Maserati Bora    15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
#> Volvo 142E       21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

``` r
# Let's first prepare a nested folder structure to keep our tables: 
create_study_forest(x, "demo_folder")

# Confirm that the files are now written: 
list.files("demo_folder", full.names = TRUE, recursive = TRUE)
#> [1] "demo_folder/data_sets/A/auto/auto.parquet"
#> [2] "demo_folder/data_sets/B/auto/auto.parquet"
#> [3] "demo_folder/data_sets/C/auto/auto.parquet"
#> [4] "demo_folder/data_sets/D/auto/auto.parquet"
```

macro_study object could be the main user-oriented interface, for
instance to get summary statistics across data sets.

``` r

x <- macro_study("demo_folder")
x
#> <metanalysis::macro_study>
#>  @ path          : chr "/home/thomaz/Documents/bioinf/metanalysis/demo_folder"
#>  @ data_slots    :List of 1
#>  .. $ auto: <metanalysis::data_slot>
#>  ..  ..@ name: chr "auto"
#>  ..  ..@ load: language arrow::open_dataset(file.path(self@path, "data_sets"), partitioning = c("study",      "type"))
#>  ..  ..@ filt: language dplyr::filter(.loaded_data, type == data_type) %>% dplyr::collect()
#>  @ study_overview: chr [1:4, 1:3] "A" "B" "C" "D" "auto" "auto" "auto" "auto" ...
```

Maybe some information could be collected like this:

``` r
x@study_overview
#>      [,1] [,2]   [,3]          
#> [1,] "A"  "auto" "auto.parquet"
#> [2,] "B"  "auto" "auto.parquet"
#> [3,] "C"  "auto" "auto.parquet"
#> [4,] "D"  "auto" "auto.parquet"
```

``` r
# We can treat our folder as a data base and open it using the arrow library: 
library(arrow)
#> Some features are not enabled in this build of Arrow. Run `arrow_info()` for more information.
#> 
#> Attaching package: 'arrow'
#> The following object is masked from 'package:utils':
#> 
#>     timestamp

# we can wrap arrow::open_dataset by calling it like this: 

y <- arrow::open_dataset(x@path)
y
#> FileSystemDataset with 4 Parquet files
#> 11 columns
#> mpg: double
#> cyl: double
#> disp: double
#> hp: double
#> drat: double
#> wt: double
#> qsec: double
#> vs: double
#> am: double
#> gear: double
#> carb: double
#> 
#> See $metadata for additional Schema metadata

# I should ensure this doesn't mess with arrow performance. 
```

Ongoing:

- Take your datasets in whatever format they are and organise them into
  an arrow compatible dataset folder structure.

  - XSummarizedExperiments could be decomposed to assay, row and col
    .parquets.
    - Need function to read them back from parquet component parts
  - Should have functions to transform common bio formats to parquet.
    Maybe funnel through mia io? Need to look into this to decide.

- harmonize metadata - see `schema` documentation of arrow

- Produce some sort of overarching metadata file in the study folder.

Later: - define analyses - see `arrow::register_scalar_function()` -
looks really nice, but almost certainly would require some nice wrapping
for our target audience.

- Some way to conveniently collect and compare across
  studies/interactions. meta-meta-data??

- A function to make the totality of the analysis into a github repo,
  likely using R/Qmd
