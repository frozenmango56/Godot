extends Sprite2D

func _process(delta):
	if (globalvariables.faceset != "none"):
		var img = load("res://assests/Ninja Adventure - Asset Pack/Actor/" + globalvariables.faceset + "/Faceset.png")
		texture = img
