extends Node
var max_health: int= 100
var health: int= max_health


func damage_player(damage:float) -> void:
	health = clamp(health - damage, 0, max_health)
	if health <= 0:
		# player dead
		
		get_tree().paused= false
		get_tree().change_scene_to_file.call_deferred("res://Scenes/UI/gameover.tscn")
		
