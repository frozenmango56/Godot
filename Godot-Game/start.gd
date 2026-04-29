extends StaticBody2D

var input = ""

func code1():
	globalvariables.player_health = 1000000000
	globalvariables.max_player_health = 1000000000
	get_tree().call_deferred("change_scene_to_file", "res://world.tscn")
	
func code2():
	globalvariables.player_health = 1
	globalvariables.max_player_health = 1
	get_tree().call_deferred("change_scene_to_file", "res://world.tscn")

func _input(event):
	if event is InputEventKey and event.pressed:
		input += char(event.unicode)
		if input.ends_with("lotsoflives"):
			code1()
		elif input.ends_with("impossible"):
			code2()
		else:
			pass
