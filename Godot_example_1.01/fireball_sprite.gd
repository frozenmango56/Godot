extends Sprite2D

var fireball = preload("res://assets/sprites/fireball/fireball.png")
var blue_fireball = preload("res://assets/sprites/fireball/blue_fireball.png")
var purple_fireball = preload("res://assets/sprites/fireball/purple_fireball.png")
var green_fireball = preload("res://assets/sprites/fireball/green_fireball.png")

func _process(delta):
	if Globalvariables.fireball_color == "blue":
		texture = blue_fireball
	elif Globalvariables.fireball_color == "purple":
		texture = purple_fireball
	elif Globalvariables.fireball_color == "green":
		texture = green_fireball
	else:
		texture = fireball
