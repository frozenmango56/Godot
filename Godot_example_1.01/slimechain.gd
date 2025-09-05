extends CollisionShape2D

func _on_slime_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("fireball"):
		Globalvariables.score += 1
		area.get_parent().queue_free()
		queue_free()
