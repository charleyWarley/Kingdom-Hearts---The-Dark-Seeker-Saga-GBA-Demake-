extends Control

signal start_pressed
signal new_game_pressed


const SOUNDS = {
	"confirm": preload("res://audio/UI Sounds/more UI/SE_SYS_WAVE_040.wav"),
	"open_dialogue": preload("res://audio/UI Sounds/BBS Menu.wav")
}
var is_start_pressed = false

@onready var saved_games_menu = preload("res://scenes/saved_games_menu.tscn")
@onready var new_game_settings = preload("res://scenes/new_game_settings.tscn")
@onready var developer_tag = $developer_tag
@onready var new_game_button = $new_game_button
@onready var current_button = $start_button
@onready var sfx = $sfx

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and current_button.can_press_button:
		if !is_start_pressed:
			emit_signal("start_pressed")
			is_start_pressed = true
			developer_tag.queue_free()
			play_sound("confirm")
			
		else:
			if new_game_button.can_press_button: 
				play_sound("open_dialogue")
				emit_signal("new_game_pressed")
			
		

func play_sound(sound):
	if SOUNDS.has(sound):
		sfx.set_stream(SOUNDS[sound])
		sfx.play()


func _on_new_game_pressed():
	var new_settings = new_game_settings.instantiate()
	get_parent().add_child(new_settings)
	new_game_button.can_press_button = false
	new_settings.game_settings_chosen.connect(Callable(
		self, 
		"_on_game_settings_chosen")
		)


func fade_to_save_games():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 1.8)
	$sora_image.set_visible(false)
	$fade_timer.start()
	print("title menu fading")
	var new_menu = saved_games_menu.instantiate()
	get_parent().add_child(new_menu)
	$music_player.fade_out()
	new_menu.game_file_selected.connect(Callable(
		get_parent().get_parent().get_parent(), 
		"_on_game_file_selected")
		)


func _on_fade_timer_timeout():
	queue_free()


func _on_game_settings_chosen():
	fade_to_save_games()
	print("game mode chosen")

