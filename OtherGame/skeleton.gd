extends CharacterBody2D

#Export a variable to make the movement speed adjustable in the inspector
var speed = 20.0
@onready var sprite = $AnimatedSprite2D
var health = 3
var direction = 0
#this variable will hold the reference to the player node once its detected
var player_node: Node2D = null

#A boolean to track if the player has entered the detection area
var player_detected = false

#a boolean to track if cyclops is not _is
var is_dead = false

#This function is called ever physics frame
func _physics_process(delta):
	#Only proceed with movement logic if not attacking
	if not is_dead:
		#Only move horizontally if the player has been detected.
		if player_detected and is_instance_valid(player_node):
			#caculate the direction from the cyclops to the player and normalize it.
			direction = (player_node.global_position - global_position).normalized()
			#set velocity
			velocity = direction * speed
		#move the character and handle collisions
		move_and_slide()


func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_node = $"../player"
		player_detected = true
