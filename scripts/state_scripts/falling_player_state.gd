class_name FallingPlayerState
extends State

@export var animation : AnimationPlayer

func enter():
#	animation.play("fall")
	Global.player.velocity.y = Global.player.JUMP_POWER * 3
	

func update(_delta):
	if Global.player.position.y >= Global.player.ground_position.y:
		transition.emit("LandingPlayerState")
