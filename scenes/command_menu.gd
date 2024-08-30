extends Control

enum button_modes {
	UNAVAILABLE,
	AVAILABLE,
	HOVERING
}
const SOUNDS = {
	"scroll": preload("res://audio/UI Sounds/more UI/SE_SYS_WAVE_039.wav"),
	"select": preload("res://audio/UI Sounds/more UI/SE_SYS_WAVE_040.wav")
}
@onready var action_button = $action_button
@onready var magic_button = $magic_button
@onready var item_button = $item_button
@onready var context_button = $context_button
var current_button = 0
var last_button = 0

func _ready():
	initialize_button(action_button, "attack", button_modes.HOVERING)
	initialize_button(magic_button, "?", button_modes.UNAVAILABLE)
	initialize_button(item_button, "item", button_modes.AVAILABLE)
	set_visible(false)
	context_button.set_visible(false)


func _process(_delta):
	if !visible: return
	if Input.is_action_just_pressed("ui_up"):
		initiate_scroll(-1)
	elif Input.is_action_just_pressed("ui_down"):
		initiate_scroll(1)
	

func initiate_scroll(direction):
	last_button = current_button
	attempt_scroll(direction)


func attempt_scroll(direction):
	current_button += direction
	if current_button < 0:
		current_button = 2
	elif current_button > 2:
		current_button = 0
	print(current_button)
	if get_button_availablity():
		scroll()
	else:
		print(current_button, " is locked")
		attempt_scroll(direction)
	
	
func scroll():
	unhover_button(last_button)
	hover_button()


func get_button_availablity() -> bool:
	var is_available = false
	match current_button:
		0:
			if action_button.current_mode == button_modes.AVAILABLE:
				is_available = true
		1:
			if magic_button.current_mode == button_modes.AVAILABLE:
				is_available = true
		2:
			if item_button.current_mode == button_modes.AVAILABLE:
				is_available = true
	print(current_button, " availablity = ", is_available)
	return is_available


func hover_button():
	match current_button:
		0:action_button.set_button_mode(button_modes.HOVERING)
		1:magic_button.set_button_mode(button_modes.HOVERING)
		2: item_button.set_button_mode(button_modes.HOVERING)
	attempt_sound("scroll")


func unhover_button(button_number):
	match button_number:
		0: action_button.set_button_mode(button_modes.AVAILABLE)
		1: magic_button.set_button_mode(button_modes.AVAILABLE)
		2: item_button.set_button_mode(button_modes.AVAILABLE)


func attempt_sound(sound: String):
	if SOUNDS.has(sound):
		match current_button:
			0:
				play_sound(action_button, SOUNDS[sound])
			1:
				play_sound(magic_button, SOUNDS[sound])
			2:
				play_sound(item_button, SOUNDS[sound])


func play_sound(button, sound):
	button.sfx.set_stream(sound)
	button.sfx.play()


func initialize_button(button, text, mode):
	button.origin = button.position
	button.set_label_text(text)
	button.set_button_mode(mode)
