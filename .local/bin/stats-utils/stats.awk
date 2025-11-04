BEGIN {
	FS = ","
	WIDTH = 15
	PARALLEL_SHARE = 0.92
	printf "\033[4;1m%*-s%*-s%*-s%*-s%*-s\033[0m\n", \
		   WIDTH, "K", WIDTH, "TEMPS", WIDTH, "ACCEL", WIDTH, "AMDAHL_ACCEL", WIDTH, "KARP-FLATT"
}

function get_k() {
	split($0, arr, " ")
	return substr(arr[1], 3)
}

NR == 2 {
	base_time = $2
	base_time_sequential = (1 - PARALLEL_SHARE) * base_time
	base_time_parallel = PARALLEL_SHARE * base_time

	printf "%*-d%*-.3f%*-.3f\n", \
		  WIDTH, get_k(), WIDTH, base_time, WIDTH, 1.0
}

NR > 2 {
	k = get_k()
	time = $2 # This is the mean time calculated by hyperfine

	acceleration = base_time / time

	amdahl_time = base_time_sequential + base_time_parallel  / k
	amdahl_accel = base_time / amdahl_time

	karp_flatt = (1/acceleration - 1/k) / (1 - 1/k)

	printf "%*-d%*-.3f%*-.3f%*-.3f%*-.3f\n", \
		   WIDTH, k, WIDTH, time, WIDTH, acceleration, WIDTH, amdahl_accel, WIDTH, karp_flatt
}
