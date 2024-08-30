extends Control

signal game_settings_chosen

const SOUNDS = {
	"move_pointer": preload("res://audio/UI Sounds/more UI/SE_SYS_WAVE_039.wav"),
	"select": preload("res://audio/UI Sounds/more UI/SE_SYS_WAVE_040.wav")
}
@onready var sfx = $sfx
@onready var normal = $normal_button
@onready var expert = $expert_button
var button_index = 0


func _ready():
	scroll_buttons()


func _process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		play_sound("move_pointer")
		button_index -= 1
		scroll_buttons()
	elif Input.is_action_just_pressed("ui_right"):
		play_sound("move_pointer")
		button_index += 1
		scroll_buttons()
	elif Input.is_action_just_pressed("ui_accept"):
		play_sound("select")
		emit_signal("game_settings_chosen")


func scroll_buttons():
	if button_index < 0:
		button_index = 1
	if button_index > 1:
		button_index = 0
	match button_index:
		0: 
			normal.color = Color.DARK_RED
			expert.color = Color.DARK_BLUE
		1: 
			expert.color = Color.DARK_RED
			normal.color = Color.DARK_BLUE


func play_sound(sound):
	if SOUNDS.has(sound):
		sfx.set_stream(SOUNDS[sound])
		sfx.play()


func _on_sfx_finished():
	if sfx.stream == SOUNDS["select"]: queue_free()
