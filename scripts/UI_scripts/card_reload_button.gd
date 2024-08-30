extends NinePatchRect

signal deck_reloaded

var reload_speed = 5

@export var card_animation : AnimationPlayer
@export var number : Sprite2D



func _on_reload_animation_animation_finished(anim_name):
	if anim_name == "reload":
		if number.frame < 2: number.frame += 1
		print("reloaded ", number.frame, " times")
		if Input.is_action_pressed("commit_command"):
			reload()
		else:
			number.frame = 0
			card_animation.play("still")
			
		


func _ready():
	number.visible = true
	card_animation.play("still")


func reload():
	card_animation.play("reload", -1, reload_speed - (number.frame + 1))


func stop_reload():
	card_animation.pause()


