extends CharacterBody2D

const SPEED = 40
@onready var animation_tree = $AnimationTree
var is_falling = false
var is_following = false
var was_following = false
var is_recovered = false
var is_staggered = false
var direction = Vector2(0, 0)
var target = null


func _ready():
	randomize_direction()

func randomize_direction():
	randomize()
	var dice = randf_range(0, 6)
	for i in dice:
		randomize()
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	
	

func _process(_delta):
	update_animation_parameters()


func _physics_process(delta):
	if is_following:
		direction = Vector2(position - target.position).normalized()
		direction = -direction
	velocity = lerp(velocity, direction * SPEED, delta)
	move_and_slide()


	
func update_animation_parameters():
	if velocity != Vector2.ZERO:
		animation_tree["parameters/conditions/is_moving"] = true
	else:
		animation_tree["parameters/conditions/is_moving"] = false
	
	if is_staggered:
		animation_tree["parameters/conditions/is_staggered"] = true
	else:
		animation_tree["parameters/conditions/is_staggered"] = true
	
	if is_recovered:
		animation_tree["parameters/conditions/is_recovered"] = true
	else:
		animation_tree["parameters/conditions/is_recovered"] = false
		
				

	#if is_falling: 
		#print("is falling")
		#animation_tree["parameters/conditions/is_falling"] = true
	#else: 
		#print("not is falling")
		#animation_tree["parameters/conditions/is_falling"] = false
	
	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/slap/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
		animation_tree["parameters/hide/blend_position"] = direction
		animation_tree["parameters/hidden/blend_position"] = direction
		animation_tree["parameters/popup/blend_position"] = direction
		animation_tree["parameters/knockback/blend_position"] = direction


func _on_detection_area_body_entered(body):
	if body.name == "sora":
		target = body
		is_following = true


func _on_animation_tree_animation_finished(anim_name):
	if anim_name.begins_with("idle"):
		is_recovered = true
		is_staggered = false
		if was_following: 
			was_following = false
			is_following = true


func _on_damage_area_area_entered(area):
	if area.name == "key_collision":
		is_staggered = true
		if is_following:
			was_following = true
			is_following = false
		print("shadow is staggered")
