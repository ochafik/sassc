#!/bin/bash

readonly DART_SASS=${DART_SASS:-$HOME/github/dart-sass}
readonly SASSC=${SASSC:-$HOME/github/sassc}

for f in $DART_SASS/benchmark/source/*.scss ; do
  echo "$(basename $f):"

  echo "  dart-sass:"
  ( cd $DART_SASS && time dart bin/sass.dart $f >/dev/null ) 2>&1 | grep real | sed -e 's/.*/    \0/'

  echo "  sassc:"
  ( cd $SASSC && time bin/sassc $f >/dev/null ) 2>&1 | grep real | sed -e 's/.*/    \0/'
done
