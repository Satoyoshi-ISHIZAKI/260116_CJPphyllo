#!/usr/bin/env bash
set -euo pipefail

# Create a QIIME 2 PairedEndFastqManifestPhred33V2 manifest TSV.
#
# Usage:
#   ./make_manifest.sh <input_dir> <output_tsv> [pattern_R1] [pattern_R2]
#
# Defaults:
#   pattern_R1='*_1*.fastq.gz'
#   pattern_R2='*_2*.fastq.gz'
#
# Example:
#   ./make_manifest.sh /scratch/microbiome pe_33_manifest.tsv
#
# The sample-id is derived from the filename by removing the R1/R2 marker
# and the file extension (e.g., sample1_R1.fastq.gz -> sample1).

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <input_dir> <output_tsv> [pattern_R1] [pattern_R2]" >&2
  exit 1
fi

input_dir="$1"
output_tsv="$2"
pattern_r1="${3:-*_1*.fastq.gz}"
pattern_r2="${4:-*_2*.fastq.gz}"

if [[ ! -d "$input_dir" ]]; then
  echo "Input directory not found: $input_dir" >&2
  exit 1
fi

# Resolve absolute path for input_dir
input_dir_abs="$(cd "$input_dir" && pwd)"

# Build an index of R2 files by sample-id
declare -A r2_map
shopt -s nullglob

for r2 in "$input_dir_abs"/$pattern_r2; do
  base="$(basename "$r2")"
  sample_id="${base%%_2*}"
  sample_id="${sample_id%%.fastq.gz}"
  sample_id="${sample_id%%.fq.gz}"
  sample_id="${sample_id%%.fastq}"
  sample_id="${sample_id%%.fq}"
  r2_map["$sample_id"]="$r2"
  done

# Write manifest header
{
  printf "sample-id\tforward-absolute-filepath\treverse-absolute-filepath\n"

  for r1 in "$input_dir_abs"/$pattern_r1; do
    base="$(basename "$r1")"
    sample_id="${base%%_1*}"
    sample_id="${sample_id%%.fastq.gz}"
    sample_id="${sample_id%%.fq.gz}"
    sample_id="${sample_id%%.fastq}"
    sample_id="${sample_id%%.fq}"

    if [[ -z "${r2_map[$sample_id]:-}" ]]; then
      echo "Warning: no R2 found for sample '$sample_id'" >&2
      continue
    fi

    printf "%s\t%s\t%s\n" "$sample_id" "$r1" "${r2_map[$sample_id]}"
  done
} > "$output_tsv"

echo "Manifest written to: $output_tsv"