class_name FallingPlayerState
extends State

@export var animation : AnimationPlayer

func enter():
#	animation.play("fall")
	Global.player.velocity.y = Global.player.JUMP_POWER * 3
	
