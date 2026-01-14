extends CharacterBody2D

@export var speed = 100
@export var diagonal_speed = 70.71
#@export var jump_speed = -250
var death = false
var punched = false
func _enter_tree() -> void:
	global_position = globalvariables.spawn_position
func _physics_process(delta):
	$CanvasLayer/Label.text = "Score: " + str(globalvariables.score) +  "\nLives: " + str(globalvariables.player_health)
	if globalvariables.player_health <= 0:
		globalvariables.spawn_position = Vector2(3335,-148)
		$AnimatedSprite2D.play("dead")
		await get_tree().create_timer(.4).timeout
		get_tree().call_deferred("change_scene_to_file", "res://world2.tscn")
		globalvariables.player_health = 10
		globalvariables.score = 0

	var xdirection = Input.get_axis("ui_left", "ui_right")
	var ydirection = Input.get_axis("ui_up", "ui_down")
	velocity.x = xdirection * speed
	velocity.y = ydirection * speed
	if velocity.x != 0 and velocity.y != 0:
		velocity.x = xdirection * diagonal_speed
		velocity.y = ydirection * diagonal_speed
	
	if Input.is_action_just_pressed("punch"):
		punched = true
	elif punched == true:
		$AnimatedSprite2D.play("punch-" + globalvariables.facing)
		if globalvariables.player_health <= 0:
			return
		elif globalvariables.player_health > 0:
			await get_tree().create_timer(.4).timeout
			punched = false
			velocity.x = 0
			velocity.y = 0
	elif xdirection > 0:
		$AnimatedSprite2D.play("walk-right")
		globalvariables.facing = "right"
	elif xdirection < 0:
		$AnimatedSprite2D.play("walk-left")
		globalvariables.facing = "left"
	elif ydirection > 0:
		$AnimatedSprite2D.play("walk-down")
		globalvariables.facing = "down"
	elif ydirection < 0:
		$AnimatedSprite2D.play("walk-up")
		globalvariables.facing = "up"
	elif globalvariables.facing == "right":
		$AnimatedSprite2D.play("idle-right")
	elif globalvariables.facing == "left":
		$AnimatedSprite2D.play("idle-left")
	elif globalvariables.facing == "down":
		$AnimatedSprite2D.play("idle-down")
	elif globalvariables.facing == "up":
		$AnimatedSprite2D.play("idle-up")

	move_and_slide()
	
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_speed
		#await get_tree().create_timer(3).timeout

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enter_house_1"):
		globalvariables.spawn_position = Vector2(0,0)
		get_tree().call_deferred("change_scene_to_file", "res://house1.tscn")
	elif area.is_in_group("exit_house_1"): 
		globalvariables.spawn_position = Vector2(3335,-148)
		get_tree().call_deferred("change_scene_to_file", "res://world2.tscn")
	#elif area.is_in_group("exit_house_2"):
		#globalvariables.spawn_position = Vector2(135,-380)
		#get_tree().call_deferred("change_scene_to_file", "res://world2.tscn")
	elif area.is_in_group("coin"):
		globalvariables.score += 1
		$CanvasLayer/Label.text = "SCORE: " + str(globalvariables.score)
		$CanvasLayer/Label.text = "LIVES: " + str(globalvariables.player_health)
		


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("enter_house_2"):
		globalvariables.spawn_position = Vector2(0,0)
		get_tree().call_deferred("change_scene_to_file", "res://house2.tscn")
	
