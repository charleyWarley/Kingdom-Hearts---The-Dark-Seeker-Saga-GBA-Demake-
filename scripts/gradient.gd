extends Control


func _ready():
	modulate = Color(1,1,1,0)


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 3)


func _on_title_menu_start_pressed():
	set_visible(false)
