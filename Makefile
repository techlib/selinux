#!/usr/bin/make -f

pps = $(foreach te,$(wildcard *.te),$(te:.te=.pp))

all: ${pps}

install: all
	semodule -u zabbix_agent.pp

clean:
	rm -f $(wildcard *.pp) $(wildcard *.mod)

%.mod: %.te
	checkmodule -M -o $@ -m $<

%.pp: %.mod
	semodule_package -o $@ -m $<


# EOF
