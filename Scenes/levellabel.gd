extends Label

func level_up():
	var levelup = $"../../Levelup"
	Globallevelscript.level += 1
	levelup.show_level_up_menu()

func _process(delta):
	# Access the global score and set the label's text
	#text = "Level: " + str(Globallevelscript.level)
	if pow(Globallevelscript.level*5, 2) + 100 <= Globalpointscript.score:
		level_up()
