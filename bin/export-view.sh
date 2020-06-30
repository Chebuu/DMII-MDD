#!/usr/bin/env bash

abspath() {
  # $1 : relative filename
  if [ -d "${1%/*}" ]; then
    echo "$(cd ${1%/*}; pwd)/${1##*/}"
  fi
}

if [ "${1}" != "--source-only" ]; then
    abspath "${@}"
fi

VIEW=$1
FOUT=$(abspath $2)

PGPORT=${PGPORT:-"5432"}
PGHOST=${PGHOST:-"127.0.0.1"}
PGDATABASE=${PGDATABASE:-"mimic"}
PGOPTIONS=${PGOPTIONS:-"--search_path=mimiciii"}

eval "PGOPTIONS=$PGOPTIONS" psql -d $PGDATABASE -p $PGPORT -h $PGHOST -c "\"COPY (SELECT * FROM $1) TO '$(abspath $2)' CSV HEADER;\""
