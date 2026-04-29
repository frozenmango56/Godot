extends CharacterBody2D

@export var speed = 100
@export var diagonal_speed = 70.71
@export var direction = 0
@onready var skin = $AnimatedSpriteGreen
var input = ""
var death = false
var punched = false
var punch_sound = false

func _enter_tree() -> void:
	global_position = globalvariables.spawn_position
	$AnimatedSpriteGreen.visible = true
	$AnimatedSpriteSand.visible = false
	$AnimatedSpriteBlack.visible = false
	
func _input(event):
	if event is InputEventKey and event.pressed:
		input += char(event.unicode)
		if input.ends_with("supersword"):
			globalvariables.sword_damage = 3
		elif input.ends_with("sneaky"):
			skin.visible = false
			skin = $AnimatedSpriteBlack
			skin.visible = true
		elif input.ends_with("greenninja"):
			skin.visible = false
			skin = $AnimatedSpriteGreen
			skin.visible = true

func _physics_process(delta):
	$CanvasLayer/Label.text = "Coins: " + str(globalvariables.coins_collected) +  "\nHealth: " + str(globalvariables.player_health)

	if globalvariables.coins_collected >= 100:
		get_tree().call_deferred("change_scene_to_file", "res://win.tscn")
		globalvariables.spawn_position = Vector2(3335,-148)
	elif globalvariables.player_health <= 0:
		death = true
		skin.play("dead")
		await get_tree().create_timer(.5).timeout
		get_tree().call_deferred("change_scene_to_file", "res://lose.tscn")
		
	elif globalvariables.hit == false:
		direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
		velocity = direction * speed
		if velocity.x != 0 and velocity.y != 0:
			velocity = direction * diagonal_speed
		
		if Input.is_action_just_pressed("punch"):
			punched = true
			punch_sound = true
		elif punched == true:
			if globalvariables.player_health <= 0:
				death = true
				return
			elif globalvariables.player_health > 0:
				if punch_sound == true:
					$Sword2.play()
					punch_sound = false
				skin.play("punch-" + globalvariables.facing)
				await get_tree().create_timer(.4).timeout
				punched = false
				velocity.x = 0
				velocity.y = 0

		elif direction.x > 0:
			skin.play("walk-right")
			globalvariables.facing = "right"
		elif direction.x < 0:
			skin.play("walk-left")
			globalvariables.facing = "left"
		elif direction.y > 0:
			skin.play("walk-down")
			globalvariables.facing = "down"
		elif direction.y < 0:
			skin.play("walk-up")
			globalvariables.facing = "up"
		elif globalvariables.facing == "right":
			skin.play("idle-right")
		elif globalvariables.facing == "left":
			skin.play("idle-left")
		elif globalvariables.facing == "down":
			skin.play("idle-down")
		elif globalvariables.facing == "up":
			skin.play("idle-up")
		move_and_slide()
	elif globalvariables.hit == true:
		#print(velocity)
		velocity = direction * Vector2(1600, 1600)
		
		move_and_slide()
		await get_tree().create_timer(.025).timeout
		globalvariables.hit = false
		
	else:
		pass

func _on_fresh_water_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_fresh_water_area_exited(area: Area2D) -> void:
	pass # Replace with function body.


func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		$AudioStreamPlayer2D.play()
		globalvariables.coins_collected += 1
		$CanvasLayer/Label.text = "SCORE: " + str(globalvariables.coins_collected)
		$CanvasLayer/Label.text = "LIVES: " + str(globalvariables.player_health)
	elif area.is_in_group("health_potion"):
		$AudioStreamPlayer2D2.play()
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
		
func _on_top_door_r_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-15,20)
		get_tree().call_deferred("change_scene_to_file", "res://house2r6.tscn")
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
		
func _on_right_door_r_5_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-115,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r6.tscn")
################################################################################
#house2 room6 doors
func _on_left_door_r_6_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(85,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r5.tscn")

func _on_bottom_door_r_6_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-15,-182)
		get_tree().call_deferred("change_scene_to_file", "res://house2r2.tscn")

func _on_top_door_r_6_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-15,20)
		get_tree().call_deferred("change_scene_to_file", "res://house2r7.tscn")
################################################################################
#house2 room7 doors
func _on_bottom_door_r_7_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-15,-182)
		get_tree().call_deferred("change_scene_to_file", "res://house2r6.tscn")

func _on_right_door_r_7_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-115,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r8.tscn")
##########################################################################
#house2 room8 doors
func _on_left_door_r_8_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(275,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r7.tscn")

func _on_right_door_r_8_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-115,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r9.tscn")
############################################################################
#house2 room9 doors
func _on_left_door_r_9_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(85,-80)
		get_tree().call_deferred("change_scene_to_file", "res://house2r8.tscn")

func _on_top_door_r_9_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-15,20)
		get_tree().call_deferred("change_scene_to_file", "res://house2r10.tscn")
#############################################################################
#house2 room 10 doors
func _on_bottom_door_r_10_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		globalvariables.spawn_position = Vector2(-80,-436)
		get_tree().call_deferred("change_scene_to_file", "res://house2r9.tscn")
############################################################################
func _on_inventory_pressed() -> void:
	pass # Replace with function body.
