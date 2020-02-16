extends Timer

enum BEHAVIORS {
	RANDOM, 
	NORMAL,
}

export(BEHAVIORS) var timer_behavior: = BEHAVIORS.RANDOM

export(float, 0.0, 10.0) var min_seconds: = 1.0
export(float, 0.0, 10.0) var max_seconds: = 10.0


func get_wait_time() -> float:
	var wt: = wait_time
	if timer_behavior == BEHAVIORS.RANDOM:
		wt = rand_range(min_seconds, max_seconds)
	return wt
