extends VideoStreamPlayer

signal cutscene_ended
signal cutscene_started

const VIDEOS = {
	"intro": preload("res://videos/new intro.ogv"),
	"chess": preload("res://videos/Chess Game.ogv")
}

var will_skip = false


func play_video(video: String):
	if VIDEOS.has(video):
		set_stream(VIDEOS[video])
		play()
		emit_signal("cutscene_started")


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and is_playing():
		if will_skip:
			end_cutscene()
		else:
			will_skip = true


func _on_finished():
	stop()


func end_cutscene():
	stop()
	will_skip = false
	emit_signal("cutscene_ended")
