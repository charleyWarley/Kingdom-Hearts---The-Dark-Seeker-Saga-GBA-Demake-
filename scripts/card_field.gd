extends Control

signal card_received

@export var active : Control
@export var player_deck : Control
var active_card : NinePatchRect

func _on_command_deck_card_activated(card):
	active_card = card
	set_active_card(true)


func set_active_card(is_player_card: bool):
	if is_player_card:
		player_deck.focus.remove_child(active_card)
		card_received.emit()
	active.add_child(active_card)
	
