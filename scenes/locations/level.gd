extends Node2D

@onready var player := $sora
@onready var start_position = $start_position

func _ready():
	player.position = start_position.position
