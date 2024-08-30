class_name CrouchingPlayerState
extends State

@export var animation : AnimationPlayer
var is_crouching = false


func enter():
	Global.player.speed = Global.player.SPEEDS.slow
	animation.play("crouch", -1, Global.player.CROUCH_SPEED)
	is_crouching = true
	print("just crouched")

func update(_delta):
	if !Global.player.is_on_floor():
		uncrouch_check()
	if !Global.player.is_crouch_togglable and Input.is_action_just_released("crouch"):
		uncrouch_check()
	elif Global.player.is_crouch_togglable and Input.is_action_just_pressed("crouch"):
		uncrouch_check()
	
func uncrouch_check():
	if Global.player.crouch_shapecast.is_colliding():
		await get_tree().create_timer(0.1).timeout
		uncrouch_check()
		return
	else:
		uncrouch()
		return
	print("can't uncrouch")
	
	
func uncrouch():
	is_crouching = false
	animation.play("crouch", -1, -Global.player.CROUCH_SPEED, true)


func _on_state_animator_animation_finished(anim_name):
	if anim_name != "crouch": return
	if is_crouching: return
	if Global.player.velocity.length() > 0:
		transition.emit("WalkingPlayerState")
	elif Global.player.velocity.length() == 0:
		transition.emit("IdlePlayerState")
