.PHONY: test
MLCOMP ?= polymlb
MLB_PATH := -mlb-path-var 'SMLPKG $(shell pwd)/lib'
SMLBUILD := $(MLCOMP) $(MLB_PATH)

test: $(shell find lib/*)
	$(SMLBUILD) -output runtests ./lib/github.com/pzel/sml-prelude/runtests.mlb
	./runtests
