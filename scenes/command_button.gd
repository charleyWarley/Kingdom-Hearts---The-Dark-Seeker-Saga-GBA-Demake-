extends Sprite2D

enum button_modes {
	UNAVAILABLE,
	AVAILABLE,
	HOVERING
}
@onready var animation_player = $AnimationPlayer
@onready var label = $command_label
@onready var sfx = $sfx
var current_mode = button_modes.UNAVAILABLE
var origin
var nudge_size = 7
	
	
func set_button_mode(mode):
	match mode:
		button_modes.UNAVAILABLE:
			current_mode = button_modes.UNAVAILABLE
			position = origin
			label["theme_override_colors/default_color"] = Color.DARK_GRAY
			play_animation("unavailable")
		button_modes.AVAILABLE:
			current_mode = button_modes.AVAILABLE
			position = origin
			label["theme_override_colors/default_color"] = Color.WHITE
			play_animation("available")
		button_modes.HOVERING:
			current_mode = button_modes.HOVERING
			position = Vector2(origin.x + nudge_size, origin.y)
			play_animation("hovering")
			label["theme_override_colors/default_color"] = Color.WHITE


func set_label_text(text):
	label.set_text(text)


func play_animation(anim: String):
	if animation_player.current_animation == anim: return
	animation_player.play(anim)
