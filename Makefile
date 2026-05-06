all: docs install pkgdown


install:
	R CMD INSTALL --no-multiarch --with-keep.source ./

docs:
	Rscript -e "devtools::document()"

pkgdown:
	Rscript -e "pkgdown::build_site(run_dont_run = TRUE, new_process = FALSE)"

pkgdown_quick:
	Rscript -e "pkgdown::build_site()"

clean:
	rm -rf doc/
	rm -rf docs/

.PHONY: all install docs pkgdown pkgdown_quick clean
