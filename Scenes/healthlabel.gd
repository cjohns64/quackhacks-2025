extends Label

@onready var health_bar: ProgressBar= $"../Healthbar"

func _ready():
	health_bar.min_value=0
	health_bar.max_value=Globalhealthscript.max_health

func _process(delta):
	# Access the global score and set the label's text
	var hp= Globalhealthscript.health
	#text = "Health: %d" % hp
	health_bar.value=hp
