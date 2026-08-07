extends Button

func _on_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://world.tscn")
	globalvariables.player_health = 20
	globalvariables.max_player_health = 20
