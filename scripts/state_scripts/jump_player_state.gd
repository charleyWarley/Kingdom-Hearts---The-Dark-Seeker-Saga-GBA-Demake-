class_name JumpingPlayerState
extends State

@export var animation : AnimationPlayer

func enter():
	Global.player.ground_position = Global.player.position
	Global.player.play_sound("jump")
	animation.play(Global.player.direction_name)
	Global.player.velocity.y = -Global.player.JUMP_POWER
	Global.player.is_grounded = false

func exit():
	animation.stop()


func update(_delta):
	if Global.player.motion_vector != Vector2.ZERO:
		animation.play(Global.player.direction_name, -1, 0.0, true)
	if Input.is_action_just_released("jump"):
		transition.emit("FallingPlayerState")
	if Global.player.is_grounded:
		if Global.player.velocity.length() > 0:
			transition.emit("WalkingPlayerState")
		elif Global.player.velocity.length() == 0:
			transition.emit("IdlePlayerState")
	#else:
	#	if Global.player.velocity.y > 0:
	#		if Input.is_action_just_released("jump"):
	#			Global.player.velocity.y = 0
	#			transition.emit("FallingPlayerState")
	#	elif Global.player.velocity.y <= 0:
		#	transition.emit("FallingPlayerState")
