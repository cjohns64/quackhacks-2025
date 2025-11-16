extends Node3D

@export_category("Plugging In Nodes")

@export_category("Game Rules")
@export var throttle : float = 1.0
@export var throttle_change_rate : float = 1.0
@export var throttle_min : float = 0.0
@export var throttle_max : float = 1.0
@export var max_speed : float = 5 # This variable is now used
@export var player_health : float = 100.0
@export var nose_rotation_speed : float = 1.0
@export var roll_rotation_speed : float = 1.0

@export_category("Mouse Controls")
@export var mouse_sensitivity : float = 0.5
@export var mouse_smoothing : float = 15.0 

var mouse_x_input: float = 0.0
var mouse_y_input: float = 0.0
var smoothed_pitch_input: float = 0.0
var smoothed_roll_input: float = 0.0

var facing_direction : Vector3
var canAct : bool = true

# --- New variable for momentum ---
var velocity: Vector3 = Vector3.ZERO # Replaces movement_direction

var equipped_weapons = {}
var equipped_passives = []


func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass


func _process(delta: float) -> void:
	facing_direction = -transform.basis.z
	
	# --- 1. GET INPUT ---
	var up_down = Input.get_axis("nose_down", "nose_up")

	# --- 2. COMBINE & SMOOTH ROTATION ---
	var target_pitch_input = mouse_y_input
	var target_roll_input = mouse_x_input
	
	smoothed_pitch_input = lerp(smoothed_pitch_input, target_pitch_input, mouse_smoothing * delta)
	smoothed_roll_input = lerp(smoothed_roll_input, target_roll_input, mouse_smoothing * delta)

	# --- 3. APPLY ROTATION ---
	if abs(smoothed_pitch_input) > 0.001:
		rotate_object_local(Vector3.RIGHT, smoothed_pitch_input * nose_rotation_speed * delta)
	
	if abs(smoothed_roll_input) > 0.001:
		rotate_object_local(Vector3.FORWARD, -smoothed_roll_input * roll_rotation_speed * delta)

	# --- 4. RESET MOUSE INPUT ---
	mouse_x_input = 0.0
	mouse_y_input = 0.0

	# --- 5. APPLY MOVEMENT & THROTTLE (Momentum-based) ---
	
	# Adjust the throttle value based on input
	if up_down != 0:
		throttle += up_down * throttle_change_rate * delta
	
	# Clamp the throttle valueww
	throttle = clampf(throttle, throttle_min, throttle_max)
	
	# --- START: New Momentum Logic ---
	
	# 1. Calculate acceleration from thrust
	# 'throttle' now acts as the force/acceleration amount
	var acceleration: Vector3 = facing_direction * throttle
	
	# 2. Apply acceleration to our velocity (building momentum)
	velocity += acceleration * delta
	
	# 3. Cap the velocity (momentum) to the ship's max_speed
	# Vector3.limit_length() is perfect for this
	velocity = velocity.limit_length(max_speed)
	
	# 4. Apply the final velocity to the ship's position
	position += velocity * delta
	
	# --- END: New Momentum Logic ---
	
	# Fire weapons
	FireWeapons(delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_motion_event: InputEventMouseMotion = event as InputEventMouseMotion
		mouse_y_input = -mouse_motion_event.relative.y * mouse_sensitivity
		mouse_x_input = -mouse_motion_event.relative.x * mouse_sensitivity


func FireWeapons(delta):
	for weapon in equipped_weapons.keys():
		var currentTimer = equipped_weapons[weapon]
		currentTimer += delta
		if currentTimer > weapon.fireRate:
			weapon.Fire()
			equipped_weapons[weapon] = 0
		else:
			equipped_weapons[weapon] = currentTimer
