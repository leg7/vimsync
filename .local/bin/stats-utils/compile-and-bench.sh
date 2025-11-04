#!/bin/sh

utils=./stats-utils
binary=exe
g++ -Wall -Wextra -O3 -fopenmp knight_mono.cpp -o "$binary"

dim=5
common_args="./$binary -n $dim"
csv_file=stats.csv

# Les valeures K sont pour le script awk qui calcule les valeures de amdahl et de karp-flatt
"$utils"/hyperfine -r 3 \
	"K=1                     $common_args" \
   	"K=2  OMP_NUM_THREADS=2  $common_args" \
   	"K=4  OMP_NUM_THREADS=4  $common_args" \
   	"K=8  OMP_NUM_THREADS=8  $common_args" \
   	"K=12 OMP_NUM_THREADS=12 $common_args" \
	--export-csv "$csv_file"

printf "\n\033[1;31mStats for nerds:\033[0m\n"
"$utils"/gawk -f "$utils"/stats.awk "$csv_file"
