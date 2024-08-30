class_name IdlePlayerState
extends State

@export var animation : AnimationPlayer

func enter():
	if Global.player == null:
		await get_tree().create_timer(0.1).timeout
	animation.play(Global.player.direction_name)


func update(_delta): 
	if !Global.player.is_grounded: 
		if Global.player.velocity.y < 0:
			transition.emit("FallingPlayerState")
		return
	if Global.player.velocity.length() > 0.0:
		transition.emit("WalkingPlayerState")
	if Input.is_action_just_pressed("jump"):
		transition.emit("JumpingPlayerState")
