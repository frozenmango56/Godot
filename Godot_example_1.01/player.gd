## Code to walk with animation including Horizontal flipping of animation.

extends CharacterBody2D

### Preload fireball and marker ###
@onready var fireball = preload("res://fireball.tscn")
@onready var fireballspawn = $fireball_spawn_marker
#########

@export var speed = 100
@export var jump_speed = -250
@export var gravity = 600
@export var push_force = 10 #added push force variable
var death = false
var upsidedown = false
var firebox = false

func _physics_process(delta):
	if death:
		return
		
	## If the lives of the player are less than 0, end the game.
	if Globalvariables.lives < 0:
		get_tree().change_scene_to_file("res://end_scene.tscn")
	
	# Add gravity every frame
	if upsidedown == false:
		velocity.y += gravity * delta
	if upsidedown == true:
		velocity.y -= gravity * delta

	# Input affects x axis only
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	
	#####Shooting. Input map bound to "L"####
	if (firebox == true) or (Input.is_action_just_pressed("shoot")):
		#Instantiate the fireball and add it to the scene
		var new_fireball = fireball.instantiate()
		get_parent().add_child(new_fireball)
		#Set the fireball's intitial position to the spawn marker's global position
		new_fireball.global_position = fireballspawn.global_position
		#Set the intial momentum for the fireball. You can adjust this value.
		var shoot_momentum = 500
		$launch.play()
		#Determine the direction and apply a linear velocity directly
		if $AnimatedSprite2D.flip_h:
			#player is facin left
			new_fireball.linear_velocity.x = -shoot_momentum
		else:
			#player is facing right
			new_fireball.linear_velocity.x = shoot_momentum

	# Flip the sprite based on the horizontal direction
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
   
	# Play the appropriate animation
	if direction != 0:
		$AnimatedSprite2D.play("walk") # Assuming you have a "run" animation
	else:
		$AnimatedSprite2D.play("idle") # Assuming you have an "idle" animation

	move_and_slide()
	$CanvasLayer/Label.text = "Score: " + str(Globalvariables.score) +  "\nLives: " + str(Globalvariables.lives)
	 # Only allow jumping when on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		$jump.play()
		
#################PUSHING RIGIDBODIES#######################3333
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			var body = collision.get_collider()
			#apply an impulse to push the rigid Body 2d away
			body.apply_central_impulse(-collision.get_normal() * push_force)

####HANDLE BORDER########
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border"):
		death = true
		Globalvariables.lives -= 1
		Globalvariables.score = 0
		#### Reload scene
		get_tree().reload_current_scene()
	elif area.is_in_group("slime") or area.is_in_group("slimechain"):
		death = true
		$AnimatedSprite2D.play("death")
		###CREATE TIMER
		await get_tree().create_timer(1).timeout
		Globalvariables.lives -= 1
		Globalvariables.score = 0
		#### Reload scene
		get_tree().reload_current_scene()
	elif area.is_in_group("coin"):
		Globalvariables.score += 1
		$CanvasLayer/Label.text = "SCORE: " + str(Globalvariables.score)
		$CanvasLayer/Label.text = "LIVES: " + str(Globalvariables.lives)
		$coin_sound.play()
	elif area.is_in_group("blue_coin") or area.is_in_group("red_coin") or area.is_in_group("orange_coin"):
		Globalvariables.score += 2
		$CanvasLayer/Label.text = "SCORE: " + str(Globalvariables.score)
		$CanvasLayer/Label.text = "LIVES: " + str(Globalvariables.lives)
		$coin_sound.play()
	elif area.is_in_group("green_coin"):
		Globalvariables.score += 3
		$CanvasLayer/Label.text = "SCORE: " + str(Globalvariables.score)
		$CanvasLayer/Label.text = "LIVES: " + str(Globalvariables.lives)
		$coin_sound.play()
	elif area.is_in_group("purple_coin"):
		Globalvariables.score += 5
		$CanvasLayer/Label.text = "SCORE: " + str(Globalvariables.score)
		$CanvasLayer/Label.text = "LIVES: " + str(Globalvariables.lives)
		$coin_sound.play()
	elif area.is_in_group("rainbow_coin"):
		Globalvariables.score += 10
		$CanvasLayer/Label.text = "SCORE: " + str(Globalvariables.score)
		$CanvasLayer/Label.text = "LIVES: " + str(Globalvariables.lives)
		$coin_sound.play()
	elif area.is_in_group("orc"):
		death = true
		await get_tree().create_timer(.5).timeout
		$AnimatedSprite2D.play("death")
		###CREATE TIMER
		await get_tree().create_timer(1).timeout
		Globalvariables.lives -= 1
		Globalvariables.score = 0
		#### Reload scene
		get_tree().reload_current_scene()
	elif area.is_in_group("speedblock"):
		speed = 400
	elif area.is_in_group("jumpblock"):
		jump_speed = -500
	elif area.is_in_group("bluefireblock"):
		Globalvariables.fireball_color = "blue"
		Globalvariables.fireball_damage = 2
	elif area.is_in_group("purplefireblock"):
		Globalvariables.fireball_color = "purple"
		Globalvariables.fireball_damage = 5
	elif area.is_in_group("greenfireblock"):
		Globalvariables.fireball_color = "green"
		Globalvariables.fireball_damage = 10
		

func _on_waterdeath_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		velocity.y = 40
		gravity = 40
		jump_speed = 0
		###CREATE TIMER
		await get_tree().create_timer(3).timeout
		Globalvariables.lives -= 1
		Globalvariables.score = 0
		get_tree().reload_current_scene()

func _on_exit_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		####world 1 exit
		#####change scenes###
		get_tree().change_scene_to_file("res://world_2.tscn")
	

func _on_secret_exit_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#####change scenes###
		get_tree().change_scene_to_file("res://secret_world.tscn")
	
func _on_go_back_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		get_tree().change_scene_to_file("res://world.tscn")

func _on_exit_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#####change scenes###
		#get_tree().change_scene_to_file("res://world_3.tscn")
		get_tree().call_deferred("change_scene_to_file", "res://elliots_world_1.tscn")

func _on_uspidedown_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		###### flips the entire chracter and all of its child nodes vertically
		scale.y =-1
		upsidedown = true

func _on_uspidedown_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		###### flips the entire chracter and all of its child nodes vertically
		scale.y = 1
		upsidedown = false

func _on_exit_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#####change scenes###
		get_tree().change_scene_to_file("res://big_world.tscn") # Replace with function body.

func _on_ladder_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		gravity = -600

func _on_ladder_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		gravity = 600

func _on_bigger_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		scale.x += 1
		scale.y += 1


func _on_exit_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#####change scenes###
		get_tree().change_scene_to_file("res://elliots_world_2.tscn")
