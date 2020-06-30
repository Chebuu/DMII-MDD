SHELL := /bin/bash

.DEFAULT_GOAL := default

SQL_DIR := sql
LIB_DIR := sql/lib
RAW_DIR := data-raw

BIN_BLD := bin/build-view.sh
BIN_EXP := bin/export-view.sh

build-demographics: 
    override libs := weightdurations.sql height-weight.sql
    $(foreach dep, $(libs), $(shell $(BIN_BLD) $(LIB_DIR)/$(dep)))
    $(shell $(BIN_BLD) $(SQL_DIR)/demographics.sql)

export-demographics:
    override view := demographics
    override outf := $(RAW_DIR)/$(view).csv
    $(shell  $(BIN_EXP) $(view) $(outf))

demographics:
    $(MAKE) build-demographics 
    $(MAKE) export-demographics

build-population: 
    $(shell $(BIN_BLD) $(SQL_DIR)/study-population.sql)

export-population:
    override view := study_population
    override outf := $(RAW_DIR)/$(view).csv
    $(shell  $(BIN_EXP) $(view) $(outf))

population:
    $(MAKE) build-population 
    $(MAKE) export-population