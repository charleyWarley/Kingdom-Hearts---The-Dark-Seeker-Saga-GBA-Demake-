extends PanelContainer

var property 
@onready var property_container = $MarginContainer/VBoxContainer
var frames_per_second : String

func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible


func _ready():
	Global.debug = self
	visible = false


func _process(delta):
	if !visible: return
	frames_per_second = "%.2f" % (1.0/delta) #calculates the frames per second to the nearest 100th place
	add_property("fps", frames_per_second, 0)
	

func add_property(title: String, value, order):
	var target
	target = property_container.find_child(title, true, false) #checks if the property already exists
	#print("property already exists")
	if !target:
		print("property added")
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
		property_container.move_child(target, order)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)
