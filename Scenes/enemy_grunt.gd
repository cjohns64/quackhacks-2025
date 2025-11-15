extends Enemy
class_name EnemyGrunt

func initialize():
	max_health = 30.0
	speed = 5.0
	
	if not weapon:
		weapon = get_node_or_null("Weapon")
	if not behavior:
		behavior = get_node_or_null("Behavior")
	
func dying():
	super.dying()
