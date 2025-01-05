.PHONY: test
# change to mlton, mlkit, etc. 
SMLBUILD := polymlb

test: $(shell find lib/*)
	$(SMLBUILD) -output runtests ./lib/github.com/pzel/sml-mlton-prelude/runtests.mlb
	./runtests

