
# Hole punch

[![Travis build status](https://travis-ci.org/karthik/holepunch.svg?branch=master)](https://travis-ci.org/karthik/holepunch) [![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
 
 
 **Motivation:** Binder is an open source project that can take ~~any~~ most GitHub repos of notebooks (R or Jupyter) and turn them into a free, live instance that not only has all dependencies ready to go but also provides Jupyter or Rstudio server to run the code on. The instances are small and should not be used to demonstrate resource intensive computation. However they are ideal for reproducing papers/figures/examples and make a great addition to any public analysis project that is being hosted on GitHub.

 [As of June 2019](https://twitter.com/mybinderteam/status/1139136841792315392), Binder enabled GitHub repositories archived on Zenodo can be launched directly from Zenodo! 
 

## Installation

```r
remotes::install_github("karthik/holepunch")
# Please report any installation problems in the issues
```


## Recommended setup up your project as a compendium


```r
library(holepunch)
write_compendium_description()
# to write a description, with dependencies listed 
# It's good practice to now go fill in the placeholder text.

write_dockerfile(maintainer = "your_name") 
# To write a dockerfile. It will automatically pick the date of the last modified file, match it to 
# that version of R and add it here. You can override this by passing r_date to some date.

generate_badge()
# This generates a badge for your readme.

# At this time 🙌 push the code to GitHub 🙌

# And click on the button or use
build_binder()
# 🤞🚀
```

#### Alternate setup methods

If for some reason you really don't want to set up your project as a compendium, then set it up by creating `runtime.txt` and `install.R`. This build will take a very long time.

```r
# Note that this particular approach will be super slow.
# -----
library(holepunch)
write_install()
# Writes install.r will all dependencies discovered in the folder
write_runtime()
# Writes a file with the current R date (proxy for version).
# Can be changed to any date (more explanation to come)
generate_badge()

# At this time, commit the files to Github

# Then click the badge on your README or run

build_binder() # to kick off the build process
# 🤞🚀
```



## Testing this package

An easy way to test this package is to visit the [binder-test](https://github.com/karthik/binder-test) repo and follow the instructions. 



## Suggestions and review

The ETA for the first release of this package is early July. Comments, suggestions for improving the workflow or any other comments welcome in the issues.

## Code of conduct

Please note that the 'holepunch' project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
