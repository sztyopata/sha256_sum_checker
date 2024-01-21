#!/usr/bin/zsh

# Define an associative array to store keyword arguments
declare -A args

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--file-to-check)
            args["flagF"]=$2
            shift 2
            ;;
        -e|--expected-checksum-value)
            args["flagE"]=$2
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [-f|--file-to-check] [-e|--expected-checksum-value]"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Access the values of keyword arguments
FILE_TO_CHECK="${args["flagF"]}"
EXPECTED_CHECKSUM="${args["flagE"]}"

# Calculate sha256 checksum value of the provided file
ACTUAL_CHECKSUM=$(sha256sum "$FILE_TO_CHECK" | cut -d ' ' -f 1)

# Compare expected checksum value to calculated one
if [ "$ACTUAL_CHECKSUM" = "$EXPECTED_CHECKSUM" ]; then
  echo "Correct checksum."
  exit 0

else
  echo "Warning. Incorrect checksum."
  exit 2

fi