extends ColorRect


func _ready():
	color = Color(0,0,0)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "color", Color(1, 1, 1), 2)
