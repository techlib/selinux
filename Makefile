#!/usr/bin/make -f

pps := $(foreach te,$(wildcard *.te),$(te:.te=.pp))

MODULES = $(foreach pp,${pps},$(basename ${pp}))
selpps = $(foreach m,${MODULES},${m}.pp)

-include local.mk


all: ${selpps}

install: $(foreach m,${MODULES},install-${m})

install-%: %.pp
	semodule -i $<

uninstall: $(foreach m,${MODULES},uninstall-${m})

uninstall-%:
	semodule -r $(word 2,$(subst -, ,$@))

clean:
	rm -f $(wildcard *.pp) $(wildcard *.mod)

%.mod: %.te
	checkmodule -M -o $@ -m $<

%.pp: %.mod
	semodule_package -o $@ -m $<


# EOF
