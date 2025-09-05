extends Area2D

func _on_slime_chain_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("fireball"):
		queue_free()
