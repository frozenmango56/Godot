extends CharacterBody2D

@export var speed = 70
var sliced = false

func _physics_process(delta: float) -> void:
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	velocity = speed * direction
	if Input.is_action_just_pressed("Slice"):
		sliced = true
	elif sliced == true:
		$AnimatedSprite2D.play("right slice")
		await get_tree().create_timer(.8).timeout
		sliced = false
	elif direction.x > 0:
		$AnimatedSprite2D.play("walking right")
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.play("walking right")
		$AnimatedSprite2D.flip_h = true
	elif direction.y > 0:
		$AnimatedSprite2D.play("walking down")
		$AnimatedSprite2D.flip_h = false
	elif direction.y < 0:
		$AnimatedSprite2D.play("walking up")
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle down")
		$AnimatedSprite2D.flip_h = false
		
	move_and_slide()
