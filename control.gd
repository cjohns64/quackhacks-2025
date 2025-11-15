extends Control
@export var mainscene = "res://sandbox.tscn"




func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(mainscene)
	pass # Replace with function body.
	



func _on_quitbutton_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
