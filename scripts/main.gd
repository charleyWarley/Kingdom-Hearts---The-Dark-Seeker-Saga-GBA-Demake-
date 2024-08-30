extends Control

const WORLDS = {
	"test_level": preload("res://scenes/locations/test_level.tscn")
}
@onready var video_player = $UI/VideoStreamPlayer
@onready var level_container = $game_window/current_level
@onready var command_menu = $UI/command_menu
@onready var status_bars = $UI/status_bars


func _on_game_file_selected():
	video_player.play_video("intro")
	var new_level = WORLDS.test_level.instantiate()
	level_container.add_child(new_level)


func _on_video_stream_player_cutscene_started():
	set_game_mode("passive")


func _on_video_stream_player_cutscene_ended():
	set_game_mode("active")


func set_game_mode(mode):
	match mode:
		"active":
			if Global.player != null:
				Global.player.is_paused = false
				command_menu.set_visible(true)
				status_bars.set_visible(true)
		"passive":
			if Global.player != null:
				Global.player.is_paused = true
				command_menu.set_visible(false)
				status_bars.set_visible(false)
