extends Control

signal file_selected(file_number)

const SOUNDS = {
	"move_pointer": preload("res://audio/UI Sounds/more UI/SE_SYS_WAVE_039.wav"),
	"select": preload("res://audio/UI Sounds/more UI/SE_SYS_WAVE_040.wav")
}

@onready var pointer = $pointer
@onready var spot1 = $pointer_spot1
@onready var spot2 = $pointer_spot2
@onready var file1 = $file1
@onready var file2 = $file2
@onready var sfx = $sfx
var current_spot = spot1
var big = 34
var small = 22

func _ready():
	pointer.position = spot1.position
	hover_file(1)
	

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		var file_number
		match current_spot:
			spot1: file_number = 1
			spot2: file_number = 2
		emit_signal("file_selected", file_number)
		play_sound("select")
	if Input.is_action_just_pressed("ui_up"):
		move_pointer("up")
		pointer.position = current_spot.position
	elif Input.is_action_just_pressed("ui_down"):
		move_pointer("down")
		pointer.set_deferred("position", current_spot.position)


func move_pointer(direction):
	play_sound("move_pointer")
	match direction:
		"up":
			match current_spot:
				spot1: hover_file(2)
				spot2: hover_file(1)
		"down":
			match current_spot:
				spot1: hover_file(2)
				spot2: hover_file(1)


func hover_file(file_number):
	match file_number:
		1:
			current_spot = spot1
			file1.size.y = big
			file2.size.y = small
		2:
			current_spot = spot2
			file2.size.y = big
			file1.size.y = small


func play_sound(sound):
	if SOUNDS.has(sound):
		sfx.set_stream(SOUNDS[sound])
		sfx.play()
