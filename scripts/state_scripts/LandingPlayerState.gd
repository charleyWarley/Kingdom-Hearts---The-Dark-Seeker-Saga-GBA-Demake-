class_name LandingPlayerState
extends State


func enter():
	Global.player.position = Global.player.ground_position
	

func update(_delta):
	if Global.player.velocity.length() == 0:
		transition.emit("IdlePlayerState")
	else:
		transition.emit("WalkingPlayerState")
