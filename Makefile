.PHONY: doc vignette

all: doc docs/GWASapi.html

# build package documentation
doc:
	R -e 'devtools::document()'

# run tests
test:
	R -e 'devtools::test()'

docs/GWASapi.html: vignettes/GWASapi.Rmd docs/badges.html docs/paste_badges.R
	R -e "rmarkdown::render('$<')"
	mv $(<D)/$(@F) $@
	cd $(@D);paste_badges.R $(@F)
