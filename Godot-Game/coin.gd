extends StaticBody2D

func _ready():
	$AnimatedSprite2D.play("default")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"): #if I touch the player group
		queue_free() #delete me from the tree
