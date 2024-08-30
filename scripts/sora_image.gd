extends TextureRect


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 5)


func _ready():
	set_modulate(Color(1, 1, 1, 0))
