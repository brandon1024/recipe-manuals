PROJECT_DIR := $(realpath $(CURDIR))
SRC_DIR     := $(PROJECT_DIR)/man
BUILD_DIR   := $(PROJECT_DIR)/build

SRC_PAGES   := $(wildcard $(SRC_DIR)/**/*.7)
REL_PAGES   := $(basename $(subst $(SRC_DIR)/,,$(SRC_PAGES)))
BUILD_PAGES := $(addprefix $(BUILD_DIR)/,$(addsuffix .md,$(REL_PAGES)))

.PHONY: all clean

all: $(REL_PAGES)

clean:
	rm -rf $(BUILD_DIR)

$(REL_PAGES): %: $(BUILD_DIR)/%.md

$(BUILD_DIR)/%.md: $(SRC_DIR)/%.7
	mkdir -p $(dir $@)
	pandoc -f man -t gfm -s -V titleblock:'# $(notdir $<)' -o $@ $<

