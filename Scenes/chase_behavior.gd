extends Node

var enemy: EnemyGrunt
var enemy_grunt: EnemyGrunt
var target_coords: Vector3

func _ready():
	enemy_grunt = self.get_parent() as EnemyGrunt
	
func move_to(delta):
	var direction = (target_coords - enemy_grunt.position)
	var distance = delta * enemy_grunt.speed
	var move_vec = direction / (distance + 50)
	self.get_parent().position += move_vec
	
func _physics_process(delta):
	target_coords = EnemyManager.player_ship.position
	move_to(delta)
	
