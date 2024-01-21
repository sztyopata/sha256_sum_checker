#!/usr/bin/zsh

if [ "$#" -ne 2 ]; then
  echo "Error. Invalid argument count. Provide exactly 2 arguments."
  exit 1

fi

FILE_TO_CHECK="$1"

EXPECTED_CHECKSUM="$2"

ACTUAL_CHECKSUM=$(sha256sum $1 | cut -d ' ' -f 1)

#echo "$ACTUAL_CHECKSUM"
if [ "$ACTUAL_CHECKSUM" = "$EXPECTED_CHECKSUM" ]; then
  echo "Correct checksum."
  exit 0

else
  echo "Warning. Incorrect checksum."
  exit 2

fi