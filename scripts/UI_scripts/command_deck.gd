extends Control

signal card_activated(card:NinePatchRect)

const SCROLL_SPEED := 0.3

@export var focus : Control
@export var left : Control
@export var right : Control
@export var unseen : Control

var current_deck := []
var card_index := 0
var focus_card := ""


func _on_card_field_card_received():
	close_gap()


func _ready():
	build_deck()
	set_focus_card()


func _process(_delta):
	if Input.is_action_just_pressed("scroll_right"):
		scroll_right()
	elif Input.is_action_just_pressed("scroll_left"):
		scroll_left()
	
	if Input.is_action_just_pressed("commit_command"):
		if focus_card == "reload":
			focus.get_child(0).reload()
		else:
			card_activated.emit(focus.get_child(0))
	elif (Input.is_action_just_released("commit_command") 
	and focus_card == "reload"):
		focus.get_child(0).stop_reload()


func build_deck():
	current_deck.append(focus.get_child(0))
	current_deck.append(right.get_child(0))
	for i in unseen.get_child_count():
		current_deck.append(unseen.get_child(i))
	current_deck.append(left.get_child(0))
	print(current_deck)


func scroll_right():
	if left.get_child_count() == 0: return
	#Remove the cards from the focus and left slots
	#Add the card from the left slot to the focus slot
	var stray_focus : NinePatchRect = focus.get_child(0)
	var stray_left : NinePatchRect = left.get_child(0)
	focus.remove_child(stray_focus)
	left.remove_child(stray_left)
	focus.add_child(stray_left)
	if right.get_child_count() > 0:
		#If there's at least three cards, including the reload card,
		#remove the card from the right slot and replace it with
		#the card from the focus slot
		var stray_right : NinePatchRect  = right.get_child(0)
		right.remove_child(stray_right)
		right.add_child(stray_focus)
		if unseen.get_child_count() > 0:
			#If the deck is larger than three cards, including the reload card,
			#move the card from the right slot to the unseen slot as the first child
			unseen.add_child(stray_right)
			unseen.move_child(stray_right, 0)
			#Then remove the last card from the unseen slot and add it to the 
			#left slot
			var stray_unseen : NinePatchRect = unseen.get_child(unseen.get_child_count() - 1)
			unseen.remove_child(stray_unseen)
			left.add_child(stray_unseen)
		else:
			#If the deck only has three cards move the card from the right slot
			#to the left slot
			left.add_child(stray_right)
	else:
		#If the deck only has two cards, move the card from the focus slot
		#to the left slot and the card from the left slot to the focus slot
		left.add_child(stray_focus)
		focus.add_child(stray_left)
	set_focus_card()


func scroll_left():
	if left.get_child_count() == 0: return
	#If there's more than one card, remove the cards from the focus slot
	#and left slot and add the card from the focus slot to the left slot
	var stray_focus : NinePatchRect = focus.get_child(0)
	var stray_left : NinePatchRect = left.get_child(0)
	focus.remove_child(stray_focus)
	left.remove_child(stray_left)
	left.add_child(stray_focus)
	if right.get_child_count() > 0:
		#If there's at least three cards, including the reload card,
		#remove the card from the right slot and move it to the focus slot
		var stray_right : NinePatchRect  = right.get_child(0)
		right.remove_child(stray_right)
		focus.add_child(stray_right)
		if unseen.get_child_count() > 0:
			#If the deck is larger than three cards, including the reload card,
			#move the first card from the unseen slot to the right slot
			var stray_unseen : NinePatchRect = unseen.get_child(0)
			unseen.remove_child(stray_unseen)
			right.add_child(stray_unseen)
			#Then add the card from the left slot to the unseen slot as the
			#last child
			unseen.add_child(stray_left)
		else:
			#If the deck only has three cards move the card from the left slot
			#to the right slot
			right.add_child(stray_left)
	else:
		#If the deck only has two cards, move the card from the focus slot
		#to the left slot and the card from the left slot to the focus slot
		left.add_child(stray_focus)
		focus.add_child(stray_left)
	set_focus_card()


func close_gap():
	var stray_right : NinePatchRect  = right.get_child(0)
	right.remove_child(stray_right)
	focus.add_child(stray_right)
	set_focus_card()


func set_focus_card():
	focus_card = focus.get_child(0).name
	print(focus_card)


func _on_reload_deck_reloaded():
	pass # Replace with function body.
