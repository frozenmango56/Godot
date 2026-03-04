extends Button

func _on_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://world2.tscn")
	globalvariables.facing = "down"
	globalvariables.player_health = 8
	globalvariables.score = 0
