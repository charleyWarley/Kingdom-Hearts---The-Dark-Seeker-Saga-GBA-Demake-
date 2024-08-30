class_name RunningPlayerState
extends State

const TOP_ANIMATION_SPEED := 1.0
@export var animation : AnimationPlayer


func enter():
	Global.player.speed = Global.player.SPEEDS.fast
	animation.play("run", -1.0, 1.0)


func update(_delta):
	set_animation_speed(Global.player.velocity.length())
	if Global.player.is_on_floor():
		if Global.player.velocity.length() == 0:
			transition.emit("IdlePlayerState")
		
		if Input.is_action_just_released("run") and !Global.player.is_run_togglable:
			transition.emit("WalkingPlayerState")
		elif Input.is_action_just_pressed("run") and Global.player.is_run_togglable:
			transition.emit("WalkingPlayerState")
			Global.player.is_run_toggled = false
		
		elif Input.is_action_just_pressed("jump"):
			transition.emit("JumpingPlayerState")

		#elif Input.is_action_just_pressed("crouch") and Global.player.is_crouch_togglable:
		#	transition.emit("CrouchingPlayerState")
		#elif Input.is_action_pressed("crouch") and !Global.player.is_crouch_togglable:
		#	transition.emit("CrouchingPlayerState")
			
	elif Global.player.velocity.y < 0:
			transition.emit("FallingPlayerState")


func set_animation_speed(speed) -> void:
	var alpha = remap(speed, 0.0, Global.player.SPEEDS.fast, 0.0, 1.0)
	animation.speed_scale = lerp(0.0, TOP_ANIMATION_SPEED, alpha)
