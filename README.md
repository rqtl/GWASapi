## GWASapi - R package to connect to the [NHGRI-EBI GWAS Catalog of Summary Statistics](https://www.ebi.ac.uk/gwas)


[![R-CMD-check](https://github.com/rqtl/GWASapi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rqtl/GWASapi/actions/workflows/R-CMD-check.yaml)
<!--
[![r-universe badge](https://rqtl.r-universe.dev/GWASapi/badges/version)](https://rqtl.r-universe.dev/GWASapi)
-->

---

See the [API documentation](https://www.ebi.ac.uk/gwas/summary-statistics/docs/)
as well as [Pjotr Prins](http://thebird.nl/)'s [documentation at
github](https://github.com/pjotrp/racket-summary-stats).

---

### Installation

You can install GWASapi from
[GitHub](https://github.com/rqtl/GWASapi).

You first need to install the
[remotes](https://remotes.r-lib.org).

    install.packages("remotes")

Then use `remotes::install_github()` to install GWASapi.

    library(remotes)
    install_github("rqtl/GWASapi")

---

### Usage

For an understanding of the
[NHGRI-EBI GWAS Catalog of Summary Statistics](https://www.ebi.ac.uk/gwas)
API, see [its documentation](https://www.ebi.ac.uk/gwas/summary-statistics/docs/),
as well as [Pjotr Prins](http://thebird.nl/)'s [documentation at
github](https://github.com/pjotrp/racket-summary-stats)

The GWASapi package has a set of functions for connecting to the
GWAS Catalog:

- `check_gwasapi()` - Check connection.
- `list_chr()` - List chromosomes
- `list_studies()` - List of studies
- `list_traits()` - List of traits
- `info_study()` - Metadata about a particular study
- `get_variant()` - Get data frame of associations for a particular variant
- `get_asso()` - Get associations for a particular chromosome region
- `get_trait_asso()` - Get associations for a particular trait

For examples, see the [online
vignette](https://kbroman.org/GWASapi/GWASapi.html), which is also
available from within R:

```r
vignette("GWASapi")
```

Note that we enforce a delay between calls to the API, to slow
repeated calls within a loop. The default is 1 sec; it can be
controlled with the option `GWASapi_delay`. For example, to make the
delay 0.5 seconds, use:

```r
options(GWASapi_delay=0.5)
```

---

### License

[GWASapi](https://github.com/rqtl/GWASapi) is released under the
[MIT license](LICENSE.md).
