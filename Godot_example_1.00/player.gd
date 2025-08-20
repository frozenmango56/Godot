## Code to walk with animation including Horizontal flipping of animation.

extends CharacterBody2D

@export var speed = 100
@export var jump_speed = -250
@export var gravity = 600
var death = false

var life = 3
var score = 0
func _physics_process(delta):
	# Add gravity every frame
	velocity.y += gravity * delta

	# Input affects x axis only
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# Flip the sprite based on the horizontal direction
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
   
	# Play the appropriate animation
	if direction != 0:
		$AnimatedSprite2D.play("default") # Assuming you have a "run" animation
	else:
		$AnimatedSprite2D.play("idle") # Assuming you have an "idle" animation

	move_and_slide()
	$CanvasLayer/Label.text = "score: " + str(score)
	# Only allow jumping when on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

####HANDLE BORDER########
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border") or area.is_in_group("slime"):
		death = true
		###CREATE TIMER
		await get_tree().create_timer(0.5).timeout
		
		get_tree().reload_current_scene()
	if area.is_in_group("coin"):
		score += 1
		$CanvasLayer/Label.text = "SCORE: " + str(score)

func _on_waterdeath_area_entered(area: Area2D) -> void:
	velocity.y = 40
	gravity = 40
	jump_speed = 0
	###CREATE TIMER
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()


func _on_exit_area_entered(area: Area2D) -> void:
	#####change scenes###
	get_tree().change_scene_to_file("res://world_2.tscn")
	
