extends StaticBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if globalvariables.player_health == globalvariables.max_player_health:
			pass
		else:
			globalvariables.player_health += 1
			queue_free()
