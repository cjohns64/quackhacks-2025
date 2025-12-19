extends Control
@export var mainscene = "res://sandbox.tscn"






func _ready():
	
	get_tree().paused= true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$"../Pausemenu".can_pause = false
	$"../Pausemenu".hide()
	


func _on_button_pressed() ->  void:
	$"../Pausemenu".can_pause = true
	get_tree().paused= false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	self.visible= false
	$click.play()
	
	



func _on_quitbutton_pressed() -> void:
	get_tree().quit()
	pass 


func _on_startbutton_mouse_entered() -> void:
	$hover.play()
	
	
	
