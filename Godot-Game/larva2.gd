extends CharacterBody2D

#Export a variable to make the movement speed adjustable in the inspector
@export var speed = 50.0
#Gravity applied to the character
@onready var sprite = $AnimatedSprite2D
var facing = "down"
#this variable will hold the reference to the player node once its detected
var player_node: Node2D = null

#A boolean to track if the player has entered the detection area
var player_detected = false

#a boolean to track if the character is currently in the middle of an attack animation.
var is_attacking = false

#a boolean to track if cyclops is not dead
var is_dead = false

#This function is called ever physics frame
func _physics_process(delta):
	#Only proceed with movement logic if not attacking
	if not is_attacking and not is_dead:
		#Only move horizontally if the player has been detected.
		if player_detected and is_instance_valid(player_node):
			#caculate the direction from the cyclops to the player and normalize it.
			var direction = (player_node.global_position - global_position).normalized()
			#set horizontal velocity toward the player
			velocity = direction * speed
			if velocity.x > 0:
				$AnimatedSprite2D.play("walk-right")
				facing = "right"
			elif velocity.x < 0:
				$AnimatedSprite2D.play("walk-left")
				facing = "left"
		else:
			#if attacking or dead stop all horizontal movement
			velocity.x = 0
		#move the character and handle collisions
		move_and_slide()

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_node = $"../greenninja"
		player_detected = true


func _on_detection_area_area_exited(area: Area2D) -> void:
	#if area.is_in_group("player"):
		#player_node = $"../greenninja"
		#player_detected = false
		pass
