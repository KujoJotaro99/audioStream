SIM ?= icarus
TOPLEVEL_LANG ?= verilog
FILELIST_JSON := filelist.json

FILELIST_SOURCES := $(shell python3 -c "import json; print(' '.join(json.load(open('$(FILELIST_JSON)'))['files']))")
TOPLEVEL := $(shell python3 -c "import json; print(json.load(open('$(FILELIST_JSON)'))['top'])")
MODULE := if_stage_test
COCOTB_LOG_LEVEL ?= INFO
SIM_BUILD ?= sim_build
WAVES ?= 1
COMPILE_ARGS += -g2012

.PHONY: python lint clean

python: clean
	$(MAKE) results.xml MODULE=$(MODULE)

lint:
	verilator --lint-only -Wall --sv $(FILELIST_SOURCES) --top-module $(TOPLEVEL)

clean::
	rm -rf sim_build __pycache__ .pytest_cache
	rm -f *.pyc *.vcd *.fst results.xml

include $(shell cocotb-config --makefile)/Makefile.sim
