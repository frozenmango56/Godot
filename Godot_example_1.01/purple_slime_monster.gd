extends CharacterBody2D

var health = 10

func _ready():
	$AnimatedSprite2D.play("default")
	#$slime_sound.play()

func _on_slime_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("fireball"):
		health -= 1
		area.get_parent().queue_free()
		#$AnimatedSprite2D.play("hurt")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.play("default")
		if health == 0:
			queue_free()
			
func _on_slime_sound_finished() -> void:
	$slime_sound.play()
