extends Node
@onready var pausemenu: Control = $"../Pausemenu"
@onready var menu: Control = $"../Menu"


func _ready():
	pausemenu.hide()
	


func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause_menu()
		

func toggle_pause_menu():
	var new_state= not get_tree().paused
	
	if pausemenu.visible:
		pausemenu.hide()
	else:
		pausemenu.show()
	get_tree().paused = new_state
