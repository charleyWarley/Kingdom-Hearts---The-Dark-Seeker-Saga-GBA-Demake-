extends CharacterBody2D

const SOUNDS_SFX = {
	"jump": preload("res://audio/Boing.wav")
}
const SOUNDS_VOICE = {
	"attack": preload("res://audio/characters/Sora/Battle/vo_sor0.wav"),
	"attack2": preload("res://audio/characters/Sora/Battle/vo_sor3.wav"),
	"critical_attack": preload("res://audio/characters/Sora/Battle/vo_sor1.wav"),
	"critical_attack2": preload("res://audio/characters/Sora/Battle/vo_sor2.wav"),
	"break": preload("res://audio/characters/Sora/Battle/vo_sor5.wav"),
	"it's over": preload("res://audio/characters/Sora/Battle/vo_sor_f6.wav")
}
const COMBO_BUFFER = 11
const SPEED = 4700
const ACCELERATION = 10.0
const DECELERATION = 80.0
const JUMP_POWER = 550
const GRAVITY = 200
var direction_name = "down_right"
var direction = Vector2(0, 1) 
var motion_vector : Vector2
var target_position : Vector2
var ground_position : Vector2
var friction = 1.0
var last_hit_time = 0.0
var combo_counter = 0
var max_combo = 2 #starting at 0
var is_grounded = true
var is_attacking = false
var is_paused = false
@onready var sfx = $sfx
@onready var voice = $voice
@onready var sprite = $sprite
@onready var ground_ray = $ground_ray


func _on_video_stream_player_cutscene_started():
	is_paused = true
	print("sora paused")


func _on_video_stream_player_cutscene_ended():
	is_paused = false
	print("sora unpaused")


func _ready():
	Global.player = self


func _process(_delta):
	if is_paused: return
	if Global.debug != null: 
		Global.debug.add_property("Direction Name", direction_name, 1)
		Global.debug.add_property("Velocity", velocity, 2)
	if ground_ray.get_collider():
		print(ground_ray.get_collider().name)
	if get_slide_collision_count() > 0:
		for i in get_slide_collision_count(): 
			print(get_slide_collision(i - 1))
	

func _physics_process(delta):
	if is_paused: return
	get_input_vector(delta)
	if !is_grounded: apply_gravity(delta) 
	move_and_slide()


func apply_gravity(delta):
	velocity.y -= GRAVITY * delta


func attack():
	if is_attacking: return
	is_attacking = true
	var time_hit := get_time()
	
	if time_hit - last_hit_time < COMBO_BUFFER and combo_counter < max_combo:
		combo_counter += 1
		match combo_counter:
			1: print("jab")
			2: print("swing")
	else:
		combo_counter = 0
		print("smash")
	
	last_hit_time = time_hit
	randomize()
	var this_number = randi_range(0, 3)
	match this_number:
		0: play_sound("attack")
		1: play_sound("attack2")
		2: play_sound("critical_attack")
		3: play_sound("critical_attack2")


func get_input_vector(delta):
	motion_vector = Vector2.ZERO
	var input_vector = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	if input_vector:
		direction = input_vector.round()
		direction_name = get_direction_name()
		motion_vector = direction.normalized() * SPEED * delta
		motion_vector = cartesian_to_isometric(motion_vector)
	else:
		if is_grounded: velocity = Vector2.ZERO
	velocity = motion_vector
	if is_attacking: 
		direction = input_vector.round()
		direction_name = get_direction_name()
		velocity = Vector2.ZERO


func cartesian_to_isometric(cartesian:Vector2) -> Vector2:
	return Vector2(cartesian.x - cartesian.y,  (cartesian.x + cartesian.y) / 2)


func get_direction_name() -> String:
	match direction:
		Vector2(1,0): return "right"
		Vector2(1,1): return "down_right"
		Vector2(0,1): return "down"
		Vector2(-1,1): return "down_left"
		Vector2(-1,0): return "left"
		Vector2(-1,-1): return "up_left"
		Vector2(0,-1): return "up"
		Vector2(1,-1): return "up_right"
		_: return ""


func play_sound(sound):
	if SOUNDS_SFX.has(sound):
		sfx.set_stream(SOUNDS_SFX[sound])
		sfx.play()
	elif SOUNDS_VOICE.has(sound):
		voice.set_stream(SOUNDS_VOICE[sound])
		voice.play()


func get_time() -> float:
	return Time.get_ticks_msec() * 0.01


