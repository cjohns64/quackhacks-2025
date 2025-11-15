extends Node3D

@export_category("Plugging In Nodes")

@export_category("Game Rules")
@export var throttle : float = 1.0
@export var throttle_min : float = 0.0
@export var throttle_max : float = 10.0
@export var player_health : float = 100.0
@export var nose_rotation_speed : float = 1.0
@export var roll_rotation_speed : float = 1.0

var direction : Vector3
var canAct : bool = true

var equipped_weapons = []
var equipped_passives = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = -transform.basis.z


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var up_down = Input.get_axis("nose_down", "nose_up")
	var left_right = Input.get_axis("roll_left", "roll_right")
	var throttle_change = Input.get_axis("throttle_down", "throttle_up")
	
	if up_down != 0:
		rotation += transform.basis.x * up_down * nose_rotation_speed * delta
	if left_right != 0:
		rotation += transform.basis.z * left_right * roll_rotation_speed * delta
	if throttle_change != 0:
		throttle += throttle_change * delta
	
	clampf(throttle, throttle_min, throttle_max)
	
	position += -transform.basis.z * throttle * delta
