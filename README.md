
Load the dataset in R
=====================

The [data/study_population.csv](data/study-population.csv) file contains
the results of a [query](sql/study-population.sql) on the MIMIC-III
database that extracts patient information along with a one-hot encoding
of ICD-9 CM diagnoses for Diabetes Mellitus Type II (DMII) and Major
Depressive Disorder (MDD).

``` r
library(tidyr)
library(dplyr)

set.seed(123)

POP_CSV <- 'data-raw/study-population.csv'

pop <- population <- read.csv(POP_CSV) %>%
  replace_na(list(dmii= 0, mdd = 0)) %>%
  mutate_all(na_if, '')

pos <- positive <- list(
  mdd = filter(pop, dmii == 0, mdd == 1), 
  dmii = filter(pop, dmii == 1, mdd == 0), 
  both = filter(pop, dmii == 1, mdd == 1) 
)

neg <- negative <- lapply(pos, function(sub) {
  pop %>% 
    filter(dmii == 0, mdd == 0) %>%
    sample_n(size=nrow(sub))
}) %>% setNames(names(pos))
```

| subject\_id | gender | dob                 | dod                 | expire\_flag | dm\_icd9 | dmii | dd\_icd9 | mdd |
|:-----------:|:------:|:--------------------|:--------------------|:------------:|:--------:|:----:|:--------:|:---:|
|      18     |    M   | 2116-11-29 00:00:00 | NA                  |       0      |    NA    |   0  |   29633  |  1  |
|      22     |    F   | 2131-05-07 00:00:00 | NA                  |       0      |    NA    |   0  |   29620  |  1  |
|     1899    |    F   | 2062-01-20 00:00:00 | 2118-09-06 00:00:00 |       1      |   25061  |   1  |   29620  |  1  |
|     2984    |    F   | 2127-09-02 00:00:00 | NA                  |       0      |   25061  |   1  |   29620  |  1  |
|     6816    |    M   | 2120-09-11 00:00:00 | NA                  |       0      |    NA    |   0  |    NA    |  0  |
|    13766    |    M   | 2111-05-24 00:00:00 | NA                  |       0      |    NA    |   0  |    NA    |  0  |

|          | DMII(+)/MDD(+) | DMII(+)/MDD(-) | DMII(-)/MDD(+) |
|----------|:--------------:|:--------------:|:--------------:|
| Size (N) |       19       |       979      |       264      |


Abstract
========

A patient was considered positive for DMII or MDD if any of the
following ICD-9 codes were recorded for that patient across all hospital
admissions.

***ICD-9 CM codes defining DMII***

Non-specific code
[250](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/default.htm)
Diabetes mellitus

-   [250.00](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.00.htm)
    DM type II or unspecified type w/o complication, not stated as
    uncontrolled)
-   [250.02](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.02.htm)
    DM type II or unspecified type w/o complication, uncontrolled)
-   [250.10](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.10.htm)
    DM type II or unspecified type w/ ketoacidosis, not stated as
    uncontrolled)
-   [250.12](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.12.htm)
    DM type II or unspecified type w/ ketoacidosis, uncontrolled)
-   [250.20](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.20.htm)
    DM type II or unspecified type w/ hyperosmolarity, not stated as
    uncontrolled)
-   [250.22](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.22.htm)
    DM type II or unspecified type w/ hyperosmolarity, uncontrolled)
-   [250.30](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.30.htm)
    DM type II or unspecified type w/ other coma, not stated as
    uncontrolled)
-   [250.32](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.32.htm)
    DM type II or unspecified type w/ other coma, uncontrolled)
-   [250.40](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.40.htm)
    DM type II or unspecified type w/ renal manifestations, not stated
    as uncontrolled)
-   [250.42](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.42.htm)
    DM type II or unspecified type w/ renal manifestations,
    uncontrolled)
-   [250.50](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.50.htm)
    DM type II or unspecified type w/ ophthalmic manifestations, not
    stated as uncontrolled)
-   [250.52](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.52.htm)
    DM type II or unspecified type w/ ophthalmic manifestations,
    uncontrolled)
-   [250.60](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.60.htm)
    DM type II or unspecified type w/ neurological manifestations, not
    stated as uncontrolled)
-   [250.62](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.62.htm)
    DM type II or unspecified type w/ neurological manifestations,
    uncontrolled)
-   [250.70](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.70.htm)
    DM type II or unspecified type w/ peripheral circulatory disorders,
    not stated as uncontrolled)
-   [250.72](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.72.htm)
    DM type II or unspecified type w/ peripheral circulatory disorders,
    uncontrolled)
-   [250.80](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.80.htm)
    DM type II or unspecified type w/ other specified manifestations,
    not stated as uncontrolled)
-   [250.82](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.82.htm)
    DM type II or unspecified type w/ other specified manifestations,
    uncontrolled)
-   [250.90](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.90.htm)
    DM type II or unspecified type w/ unspecified complication, not
    stated as uncontrolled)
-   [250.92](http://www.icd9data.com/2014/Volume1/240-279/249-259/250/250.92.htm)
    DM type II or unspecified type w/ unspecified complication,
    uncontrolled)

***ICD-9 CM codes defining MDD***

Non-specific code
[296](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/default.htm)
Episodic mood disorders

-   [296.20](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.20.htm)
    Major depressive affective disorder, single episode, unspecified
-   [296.21](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.21.htm)
    Major depressive affective disorder, single episode, mild
-   [296.22](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.22.htm)
    Major depressive affective disorder, single episode, moderate
-   [296.23](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.23.htm)
    Major depressive affective disorder, single episode, severe
-   [296.24](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.24.htm)
    Major depressive affective disorder, single episode, severe
-   [296.25](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.25.htm)
    Major depressive affective disorder, single episode, in partial or
    unspecified remission
-   [296.26](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.26.htm)
    Major depressive affective disorder, single episode, in full
    remission

Non-specific code
[296.3](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.3.htm)
Major depressive disorder recurrent episode

-   [296.30](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.30.htm)
    Major depressive affective disorder, recurrent episode, unspecified
-   [296.31](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.31.htm)
    Major depressive affective disorder, recurrent episode, mild
-   [296.32](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.32.htm)
    Major depressive affective disorder, recurrent episode, moderate
-   [296.33](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.33.htm)
    Major depressive affective disorder, recurrent episode, severe, w/o
    mention of psychotic behavior
-   [296.34](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.34.htm)
    Major depressive affective disorder, recurrent episode, severe,
    specified as with psychotic behavior
-   [296.35](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.35.htm)
    Major depressive affective disorder, recurrent episode, in partial
    or unspecified remission
-   [296.36](http://www.icd9data.com/2014/Volume1/290-319/295-299/296/296.36.htm)
    Major depressive affective disorder, recurrent episode, in full
    remission
