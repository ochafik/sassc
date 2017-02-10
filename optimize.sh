#!/bin/bash

readonly DART_SASS=${DART_SASS:-../dart-sass}
readonly training_file="${1:-$DART_SASS/benchmark/source/preceding_sparse_extend.scss}"
readonly profile_file=$PWD/profile.data

rebuild_with_flags() {
  local flags="$*"

  make clean
  CFLAGS=${flags} CXXFLAGS=${flags} LDFLAGS=${flags} make sassc
}

rm -fR "${profile_file}"
rebuild_with_flags "-fprofile-generate=${profile_file}"
time bin/sassc ${training_file}
rebuild_with_flags "-fprofile-use=${profile_file}"
time bin/sassc ${training_file}
