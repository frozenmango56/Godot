extends Node2D

func _on_question_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		$powerup.play()
