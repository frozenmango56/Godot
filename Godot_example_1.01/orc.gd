extends CharacterBody2D

#Export a variable to make the movement speed adjustable in the inspector
@export var speed = 50.0
# The jump force of the charavcter
@export var jump_force = 270.0
#Gravity applied to the character
@export var gravity = 980.0
@onready var sprite = $AnimatedSprite2D

#this variable will hold the reference to the player node once its detected
var player_node: Node2D = null

#A boolean to track if the player has entered the detection area
var player_detected = false

#a boolean to track if the character is currently in the middle of an attack animation.
var is_attacking = false

#a boolean to track if orc is not dead
var is_dead = false

#This function is called ever physics frame
func _physics_process(delta):
	#apply gravity to vertical velocity
	velocity.y += gravity * delta
	
	#Only proceed with movement logic if not attacking
	if not is_attacking and not is_dead:
		#Only move horizontally if the player has been detected.
		if player_detected and is_instance_valid(player_node):
			#caculate the direction from the orc to the player and normalize it.
			var direction = (player_node.global_position - global_position).normalized()
			#set horizontal velocity toward the player
			velocity.x = direction.x * speed
			sprite.play("walk")
			#flip the orc's sprite based on its movement direction.
			if velocity.x < 0:
				#face left if moving left
				sprite.flip_h = true
			elif velocity.x > 0:
				#face left if moving left
				sprite.flip_h = false
		else:
			#if attacking or dead stop all horizontal movement
			velocity.x = 0
		#move the character and handle collisions
		move_and_slide()
	
	#check if the character has collided with a wall while moving
	if is_on_wall():
		#jump if touching wall
		velocity.y = -jump_force	
				


func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_node = $"../player"
		player_detected = true


func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_node = $"../player"
		player_detected = false
