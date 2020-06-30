#!/usr/bin/env bash

source absolute-path.sh

PGPORT=${PGPORT:-"5432"}
PGHOST=${PGHOST:-"127.0.0.1"}
PGDATABASE=${PGDATABASE:-"mimic"}
PGOPTIONS=${PGOPTIONS:-"--search_path=mimiciii"}

psql -d mimic -c "COPY (SELECT * FROM $1) TO '$(abspath $2)' CSV HEADER;"
  