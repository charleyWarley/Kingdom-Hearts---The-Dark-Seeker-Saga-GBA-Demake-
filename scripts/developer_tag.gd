extends Control

func _ready():
	set_visible(false)


func _on_timer_timeout():
	set_visible(true)
