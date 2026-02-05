extends CharacterBody2D

#Export a variable to make the movement speed adjustable in the inspector
var speed = 20.0
@onready var sprite = $AnimatedSprite2D
var health = 3
var facing = "down"
var direction = 0
#this variable will hold the reference to the player node once its detected
var player_node: Node2D = null

#A boolean to track if the player has entered the detection area
var player_detected = false

#a boolean to track if cyclops is dead
var is_dead = false

func _physics_process(delta):
	#Only proceed with movement logic if not attacking
	if not is_dead:
		#Only move horizontally if the player has been detected.
		if player_detected and is_instance_valid(player_node):
			#caculate the direction from the cyclops to the player and normalize it.
			direction = (player_node.global_position - global_position).normalized()
			#set velocity
			velocity = direction * speed
			if velocity.x > 0 and direction.x > abs(direction.y):
				$AnimatedSprite2D.play("walk-right")
				facing = "right"
			elif velocity.x < 0 and direction.x < abs(direction.y) * -1:
				$AnimatedSprite2D.play("walk-left")
				facing = "left"
			elif velocity.y > 0:
				$AnimatedSprite2D.play("walk-down")
				facing = "down"
			elif velocity.y < 0:
				$AnimatedSprite2D.play("walk-up")
				facing = "up"
		else:
			#if attacking or dead stop all horizontal movement
			velocity.x = 0
		#move the character and handle collisions
		move_and_slide()

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_node = $"../player"
		player_detected = true

func _on_hit_area_area_entered(area: Area2D) -> void:
	#print("in hit area:", area.name, area.get_groups())
	if area.is_in_group("sword"):
		#print("hit by sword")
		health -= 1
		if health <= 0:
			queue_free()
	if area.is_in_group("player"):
		globalvariables.player_health -= 1
		globalvariables.hit = true
		player_node.direction = direction
