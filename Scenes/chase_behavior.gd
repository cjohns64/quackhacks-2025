extends Node

var enemy: EnemyGrunt

var target_coords: Vector3

func _ready():
	pass
	
func move_to(delta):
	var direction = (target_coords - self.get_parent().position)
	var distance = delta * 0.000001 * self.get_parent().speed
	var move_vec = direction / (distance + 50)
	self.get_parent().position += move_vec
	
func _physics_process(delta):
	target_coords = EnemyManager.player_ship.position
	move_to(delta)
	
