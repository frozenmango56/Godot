extends CharacterBody2D

var health = 10

func _ready():
	$AnimatedSprite2D.play("default")
	#$slime_sound.play()

func _on_slime_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("fireball"):
		health -= Globalvariables.fireball_damage
		area.get_parent().queue_free()
		#$AnimatedSprite2D.play("hurt")
		if health <= 0:
			queue_free()
			Globalvariables.score += 1
			
func _on_slime_sound_finished() -> void:
	$slime_sound.play()
