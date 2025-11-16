extends Control

# call show_level_up_menu to start whole level and buff
# selection process

var upgrade_options = [
	{"name": "Increased Max Health", "description": "+20 Max HP"},
	{"name": "Faster Movement", "description": "+10% Speed"},
	{"name": "Extra Damage", "description": "+15% Damage"},
	{"name": "Health Regeneration", "description": "Heal 1 HP per second"},
	{"name": "Attack Speed", "description": "+20% Attack Speed"},
	{"name": "Projectile Count", "description": "+1 Projectile"},
	{"name": "Critical Chance", "description": "+10% Crit Chance"},
	{"name": "Shield", "description": "Gain a shield that blocks 50 damage"},
]

func _input(event):
	if event.is_action_pressed("level_up"):
		print("level up pressed!")
		show_level_up_menu()

@export var button_container: VBoxContainer

signal upgrade_selected(upgrade_name: String)

func _ready():
	# hide by default
	custom_minimum_size = Vector2(600, 400)
	position = Vector2(400, 200)
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.933, 0.102, 0.2, 1.0)
	style.border_color = Color(0.8, 0.6, 0.2)
	style.set_border_width_all(3)
	add_theme_stylebox_override("panel", style)
	hide()

func show_level_up_menu():
	clear_buttons()
	get_tree().paused = true
	generate_random_options(3)
	show()

func generate_random_options(n: int):
	var available = upgrade_options.duplicate()
	available.shuffle()
	for i in range(min(n, available.size())):
		create_upgrade_button(available[i])
	
func create_upgrade_button(upgrade: Dictionary):
	var button = Button.new()
	button.text = upgrade["name"] + "\n" + upgrade["description"]
	button.custom_minimum_size = Vector2(800, 200)
	button.pressed.connect(_on_upgrade_selected.bind(upgrade["name"]))
	button_container.add_child(button)

func _on_upgrade_selected(upgrade_name: String):
	print("Selected upgrade: ", upgrade_name)
	upgrade_selected.emit(upgrade_name)
	hide()
	get_tree().paused = false
	
func clear_buttons():
	for child in button_container.get_children():
		child.queue_free()
	
	
	
	
	
	
	
