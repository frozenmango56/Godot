extends Area2D

func _on_questionarea_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		$powerup.play()
