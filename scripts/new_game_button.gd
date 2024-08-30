extends Control


var can_press_button = false


func _ready():
	set_modulate(Color(1,1,1,0))


func _on_title_menu_start_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 1.2)
	$button_timer.start()


func _on_button_timer_timeout():
	can_press_button = true
