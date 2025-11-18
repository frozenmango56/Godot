extends CharacterBody2D

@export var speed = 100
#@export var jump_speed = -250
var death = false
var punched = false
var facing = "down"

func _physics_process(delta):
	if death:
		return

	# Input affects x axis only
	var xdirection = Input.get_axis("ui_left", "ui_right",)
	velocity.x = xdirection * speed
	var ydirection = Input.get_axis("ui_up", "ui_down")
	velocity.y = ydirection * speed
	
	if Input.is_action_just_pressed("punch"):
		punched = true
	elif punched == true:
		$AnimatedSprite2D.play("punch")
		await get_tree().create_timer(.5).timeout
		punched = false
	elif xdirection > 0:
		$AnimatedSprite2D.play("walk-right")
		facing = "right"
	elif xdirection < 0:
		$AnimatedSprite2D.play("walk-left")
		facing = "left"
	elif ydirection > 0:
		$AnimatedSprite2D.play("walk-down")
		facing = "down"
	elif ydirection < 0:
		$AnimatedSprite2D.play("walk-up")
		facing = "up"
	elif facing == "right":
		$AnimatedSprite2D.play("idle-right")
	elif facing == "left":
		$AnimatedSprite2D.play("idle-left")
	elif facing == "down":
		$AnimatedSprite2D.play("idle-down")
	elif facing == "up":
		$AnimatedSprite2D.play("idle-up")

	move_and_slide()
	
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_speed
		#await get_tree().create_timer(3).timeout
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("border"):
		death = true
		#Globalvariables.lives -= 1
		#Globalvariables.score = 0
		#### Reload scene
		get_tree().reload_current_scene()
