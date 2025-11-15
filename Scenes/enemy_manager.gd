extends Node3D

# hold enemies, types, etc.
@export var ememy_types:Array[PackedScene] = []
var spawn_range:float = 1000

# manage timers, spawning, stopping on menus

# function to run through list of enemies and pause them

# function to run through list of enemies and damage them

# function to run through list of enemies and destroy selected types

func SpawnEnemy(enemy_index:int) -> void:
	# random angle between -PI and +PI
	var phi = 2 * PI * randf() - PI
	var theta = 2 * PI * randf() - PI
	var x = spawn_range * sin(theta) * cos(phi)
	var y = spawn_range * sin(theta) * sin(phi)
	var z = spawn_range * cos(theta)
	# add current position to spawn position
	var spawn_pos:Vector3 = Vector3(x, y, z)
	spawn_pos += self.position
	# spawn enemy
	var newscene:Node3D = self.ememy_types[enemy_index].instantiate()
	get_tree().add_child(newscene)
	# update location
	newscene.position = spawn_pos

func _process(delta: float) -> void:
	pass
