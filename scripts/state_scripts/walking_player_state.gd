class_name WalkingPlayerState
extends State

@export var animation : AnimationPlayer
@export var top_animation_speed : float = 2.0


func enter() -> void:
	pass

func exit() -> void:
	animation.stop()

func update(_delta):
	animate_walk()
	#set_animation_speed(Global.player.velocity.length())
	if Global.player.is_grounded:
		if Global.player.velocity.length() == 0.0:
			transition.emit("IdlePlayerState")
		elif Input.is_action_just_pressed("jump"):
			transition.emit("JumpingPlayerState")
	else:
		if Global.player.velocity.y < 0:
			transition.emit("FallingPlayerState")
	

func animate_walk():
	var attempt = Global.player.direction_name
	if animation.current_animation == attempt: return
	animation.play(attempt, -1.0, 1.0)


func set_animation_speed(speed):
	var alpha = remap(speed, 0.0, Global.player.SPEEDS.normal, 0.0, 1.0)
	animation.speed_scale = lerp(0.0, top_animation_speed, alpha)
