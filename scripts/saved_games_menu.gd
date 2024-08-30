extends Control

signal game_file_selected


func _on_files_file_selected(file_number):
	print("file ", file_number, " selected")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 2)
	emit_signal("game_file_selected")
	$Timer.start()

func _on_timer_timeout():
	queue_free()


func _ready():
	modulate = Color(1,1,1,0)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 2)
