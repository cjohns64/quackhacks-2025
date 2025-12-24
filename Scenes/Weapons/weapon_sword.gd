extends Node3D

@export var frequency: float = 70.0 # degrees per second

@onready var sfx: AudioStreamPlayer3D = $sword2/RigidBody3D/SwordLoopFX
@onready var loop_timer: Timer = $sword2/RigidBody3D/LoopTimer

var active := false

func _ready() -> void:
	self.rotation.z = randf() * 2.0 * PI - PI

	# Sync sound to rotation: play once per full spin
	loop_timer.wait_time = 360.0 / frequency
	loop_timer.timeout.connect(_play_whoosh)

	_stop_loop()

func _physics_process(delta: float) -> void:
	self.rotate(self.transform.basis.y, delta * frequency * PI / 180.0)

func activate() -> void:
	if active: return
	active = true
	_play_whoosh()
	loop_timer.start()

func deactivate() -> void:
	_stop_loop()

func _play_whoosh() -> void:
	# prevents stacking/overlap
	if sfx.playing:
		sfx.stop()
	sfx.play()

func _stop_loop() -> void:
	active = false
	loop_timer.stop()
	#if sfx.playing:
		#sfx.stop()

func _on_rigid_body_3d_body_entered(body: Node) -> void:
	if body.is_in_group("Enemies"):
		body.DestroyEnemy()
