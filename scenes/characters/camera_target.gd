extends Marker2D

const FOLLOW_SPEED = 1
@onready var player = $"../sora"
var is_following = true
var compensation = Vector2(0,0)

func _process(delta):
	if !is_following: return
	match player.direction_name:
		"up": compensation = Vector2(24, -36)
	position.x = lerp(position.x, player.position.x + compensation.x, FOLLOW_SPEED * delta)
	position.y = lerp(position.y, player.position.y + compensation.y, FOLLOW_SPEED * delta)
		
