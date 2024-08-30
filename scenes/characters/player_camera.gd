extends Node2D

const FOLLOW_SPEED = 1.5
const FOLLOW_DRAG = 0.95

var parent = null
@export var camera : Camera2D

func _ready():
	set_as_top_level(true)
	parent = get_parent()

func _process(delta):
	if position == parent.position: return
	position = lerp(position, parent.position, FOLLOW_SPEED * delta)



func _on_video_stream_player_cutscene_ended():
	camera.make_current()
