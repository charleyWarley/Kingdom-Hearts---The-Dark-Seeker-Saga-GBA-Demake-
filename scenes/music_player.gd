extends AudioStreamPlayer

var fade_duration = 3
var elapsed_time = 0
var initial_volume = -80
var target_volume = 0





func _process(_delta):
	elapsed_time += get_process_delta_time()
	if elapsed_time < fade_duration:
		volume_db = lerp(initial_volume, target_volume, elapsed_time / fade_duration)
	else:
		elapsed_time = 0
		volume_db = target_volume
		set_process(false)


func fade_out():
	initial_volume = 0
	target_volume = -80
	set_process(true)

func fade_in():
	play()
	set_process(true)
	initial_volume = -80
	target_volume = 0
