extends Control
@export var mainscene: String = "res://sandbox.tscn"
@export var can_pause: bool = false

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if not can_pause:
		return

	# IMPORTANT: ignore key-repeat (echo) so ESC doesn't toggle twice
	if event is InputEventKey and event.echo:
		return

	if event.is_action_pressed("pause"):
		toggle_pause_menu()

func toggle_pause_menu() -> void:
	# Toggle using the ACTUAL paused state (not visible)
	if get_tree().paused:
		# UNPAUSE
		get_tree().paused = false
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		# PAUSE
		get_tree().paused = true
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_quit_mouse_entered() -> void:
	$hover.play()
