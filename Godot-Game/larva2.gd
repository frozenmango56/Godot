extends CharacterBody2D

@onready var enemy_scene = preload("res://larva2.tscn")

#Export a variable to make the movement speed adjustable in the inspector
@export var speed = 20.0
#Gravity applied to the character
@onready var sprite = $AnimatedSprite2D
var health = 1
var hit = 0
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
		player_node = $"../player"
		player_detected = true


func _on_detection_area_area_exited(area: Area2D) -> void:
	#if area.is_in_group("player"):
		#player_node = $"../greenninja"
		#player_detected = false
		pass


func _on_hit_area_area_entered(area: Area2D) -> void:
	#print("in hit area:", area.name, area.get_groups())
	if area.is_in_group("sword"):
		#print("hit by sword")
		health -= 1
		if hit == 2:
			queue_free()
		elif health <= 0:
			hit += 1
			health = 1
			if globalvariables.facing == "up":
				position.y -= 25
				position.x += 15
				var new_enemy = enemy_scene.instantiate()
				# Set the new enemy's position near the current one
				new_enemy.global_position = global_position + Vector2(-30, 0)
				new_enemy.hit = self.hit
				# Add it to the parent (World) so it's a sibling, not a child
				get_parent().add_child(new_enemy)
			elif globalvariables.facing == "down":
				position.y += 25
				position.x += 15
				var new_enemy = enemy_scene.instantiate()
				# Set the new enemy's position near the current one
				new_enemy.global_position = global_position + Vector2(-30, 0)
				new_enemy.hit = self.hit
				# Add it to the parent (World) so it's a sibling, not a child
				get_parent().add_child(new_enemy)
			elif globalvariables.facing == "right":
				position.x += 25
				position.y += 15
				var new_enemy = enemy_scene.instantiate()
				# Set the new enemy's position near the current one
				new_enemy.global_position = global_position + Vector2(0, -30)
				new_enemy.hit = self.hit
				# Add it to the parent (World) so it's a sibling, not a child
				get_parent().add_child(new_enemy)
			elif globalvariables.facing == "left":
				position.x += -25
				position.y += 15
				var new_enemy = enemy_scene.instantiate()
				# Set the new enemy's position near the current one
				new_enemy.global_position = global_position + Vector2(0, -30)
				new_enemy.hit = self.hit
				# Add it to the parent (World) so it's a sibling, not a child
				get_parent().add_child(new_enemy)
				
	if area.is_in_group("player"):
		#print("hit player")
		globalvariables.player_health -= 1
		#print(globalvariables.player_health)
		# Get the CharacterBody2D that owns this Area2D
		var player := area.get_parent() as CharacterBody2D
		if player:
			var direction = (player.global_position - global_position).normalized()
			player.global_position += direction * 40  # 40 = knockback distance
