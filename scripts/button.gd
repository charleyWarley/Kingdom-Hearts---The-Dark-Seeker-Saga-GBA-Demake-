extends Control
class_name CustomButton

var visible_color = Color(1, 1, 1, 1)
var invisible_color = Color(1, 1, 1, 0)
var start_position = Vector2(-248, 153)
var end_position = Vector2(0, 153)
var can_press_button = false


func _on_button_pressed():
	can_press_button = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", invisible_color, 0.3)


func _ready():
	position = start_position


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_position, 1.5)
	can_press_button = true
