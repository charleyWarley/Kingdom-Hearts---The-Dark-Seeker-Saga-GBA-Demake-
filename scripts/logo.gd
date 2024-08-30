extends TextureRect


var visible_color = Color(1, 1, 1, 1)
var invisible_color = Color(1, 1, 1, 0)
var small = Vector2(156, 100)
var large = Vector2(240, 154)

func _on_button_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", invisible_color, 0.3)


func _ready():
	size = large
	var tween = get_tree().create_tween()
	tween.tween_property(self, "size", small, 1.8)
