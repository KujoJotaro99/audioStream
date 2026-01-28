FILELIST_JSON := filelist.json

json = $(shell python3 -c "import json; v = json.load(open('$(FILELIST_JSON)'))['$(1)']; print(' '.join(v) if isinstance(v, list) else v)")

TOPLEVEL     := $(call json,top)
RTL_SOURCES  := $(call json,files)
TEST_TOP     := $(call json,test_top)
TEST_SOURCES := $(call json,test_files)

SEED  ?= 1
WAVES ?= 0

SIM_BUILD := sim_build$(if $(filter 1,$(WAVES)),_waves)
SIM_BIN   := $(SIM_BUILD)/V$(TEST_TOP)

VERILATOR_FLAGS := --binary --timing --assert -j 0 -Wno-fatal \
                   --top-module $(TEST_TOP) -Mdir $(SIM_BUILD)
PLUSARGS := +verilator+seed+$(SEED)

ifeq ($(WAVES),1)
VERILATOR_FLAGS += --trace-fst
PLUSARGS += +waves
endif

.PHONY: test lint clean

test: $(SIM_BIN)
	./$(SIM_BIN) $(PLUSARGS)

$(SIM_BIN): $(RTL_SOURCES) $(TEST_SOURCES) $(FILELIST_JSON)
	verilator $(VERILATOR_FLAGS) $(RTL_SOURCES) $(TEST_SOURCES)

lint:
	verilator --lint-only -Wall --sv $(RTL_SOURCES) --top-module $(TOPLEVEL)

clean::
	rm -rf sim_build sim_build_waves *.vcd *.fst
