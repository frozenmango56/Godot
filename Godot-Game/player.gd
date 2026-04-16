extends CharacterBody2D

@export var speed = 100
@export var diagonal_speed = 70.71
@export var direction = 0
#@export var jump_speed = -250
var death = false
var punched = false

func _enter_tree() -> void:
	global_position = globalvariables.spawn_position
	
func _physics_process(delta):
	$CanvasLayer/Label.text = "Score: " + str(globalvariables.score) +  "\nLives: " + str(globalvariables.player_health)

	if globalvariables.score >= 100:
		get_tree().call_deferred("change_scene_to_file", "res://win.tscn")
	elif globalvariables.player_health <= 0:
		death = true
		globalvariables.spawn_position = Vector2(3335,-148)
		$AnimatedSprite2D.play("dead")
		await get_tree().create_timer(.5).timeout
		get_tree().call_deferred("change_scene_to_file", "res://lose.tscn")
		
	elif globalvariables.hit == false:
		direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
		velocity = direction * speed
		if velocity.x != 0 and velocity.y != 0:
			velocity = direction * diagonal_speed
		
		if Input.is_action_just_pressed("punch"):
			punched = true
		elif punched == true:
			if globalvariables.player_health <= 0:
				death = true
				return
			elif globalvariables.player_health > 0:
				$AnimatedSprite2D.play("punch-" + globalvariables.facing)
				await get_tree().create_timer(.4).timeout
				punched = false
				velocity.x = 0
				velocity.y = 0
				
		elif direction.x > 0:
			$AnimatedSprite2D.play("walk-right")
			globalvariables.facing = "right"
		elif direction.x < 0:
			$AnimatedSprite2D.play("walk-left")
			globalvariables.facing = "left"
		elif direction.y > 0:
			$AnimatedSprite2D.play("walk-down")
			globalvariables.facing = "down"
		elif direction.y < 0:
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
	elif globalvariables.hit == true:
		#print(velocity)
		velocity = direction * Vector2(1600, 1600)
		
		move_and_slide()
		await get_tree().create_timer(.025).timeout
		globalvariables.hit = false
		globalvariables.hit_again = false
	
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_speed
		#await get_tree().create_timer(3).timeout

func _on_fresh_water_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_fresh_water_area_exited(area: Area2D) -> void:
	pass # Replace with function body.


func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		globalvariables.score += 1
		$CanvasLayer/Label.text = "SCORE: " + str(globalvariables.score)
		$CanvasLayer/Label.text = "LIVES: " + str(globalvariables.player_health)
	else:
		pass
		
#########################################################################
#house 1 doors
func _on_house_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(0,0)
		get_tree().call_deferred("change_scene_to_file", "res://house1.tscn")
		
func _on_exit_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"): 
		globalvariables.spawn_position = Vector2(3335,-148)
		get_tree().call_deferred("change_scene_to_file", "res://world.tscn")
		
##########################################################################
#house2 room1 doors
func _on_house_2r_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(0,0)
		get_tree().call_deferred("change_scene_to_file", "res://house2r1.tscn")

func _on_exit_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(135,-370)
		get_tree().call_deferred("change_scene_to_file", "res://world.tscn")

func _on_right_door_r_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-115,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r2.tscn")
		
func _on_left_door_r_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(85,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r4.tscn")
		
func _on_top_door_r_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-15,20)
		get_tree().call_deferred("change_scene_to_file", "res://house2r5.tscn")
##########################################################################
#house2 room2 doors
func _on_left_door_r_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(100,-45)
		get_tree().call_deferred("change_scene_to_file", "res://house2r1.tscn")

func _on_right_door_r_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-115,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r3.tscn")
############################################################################
#house2 room3 doors
func _on_left_door_r_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(85,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r2.tscn")
############################################################################
#house2 room4 doors
func _on_right_door_r_4_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-116,-45)
		get_tree().call_deferred("change_scene_to_file", "res://house2r1.tscn")
###########################################################################
#house2 room5 doors
func _on_bottom_door_r_5_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-15,-102)
		get_tree().call_deferred("change_scene_to_file", "res://house2r1.tscn")
