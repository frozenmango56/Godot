extends Button

func _on_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://start.tscn")
	globalvariables.facing = "down"
	globalvariables.coins_collected = 0
	globalvariables.monsters_defeated = 0
	globalvariables.spawn_position = Vector2(3335,-148)
	globalvariables.sword_damage = 1
