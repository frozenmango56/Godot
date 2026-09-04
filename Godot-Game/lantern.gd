extends CharacterBody2D

#Define the signal
signal burn_tree(tree_number)

#Export a variable to make the movement speed adjustable in the inspector
var speed = 20.0
@onready var sprite = $AnimatedSprite2D
@onready var potion = preload("res://health_potion.tscn")
@onready var coin = preload("res://coin.tscn")
var health = 3
var facing = "down"
var direction = Vector2(0,0)
#this variable will hold the reference to the player node once its detected
var player_node: Node2D = null
var player_in_range = false
var tree1_in_range = false
var tree2_in_range = false
var tree3_in_range = false
var tree4_in_range = false
var tree5_in_range = false
#A boolean to track if the player has entered the detection area
var player_detected = false
#a boolean to track if cyclops is not dead
var is_dead = false

func _ready():
	$AnimatedSprite2D2.visible = false

#This function is called ever physics frame
func _physics_process(delta):
	$Detection_Area/CollisionShape2D.shape.radius = 65.12 * globalvariables.enemy_sight
	player_node = $"../player"
	direction = (player_node.global_position - global_position).normalized()
	#Only proceed with movement logic if not attacking
	if not is_dead:
		#Only move if the player has been detected.
		if (player_detected or globalvariables.goldenmode == true) and is_instance_valid(player_node) and globalvariables.stealthmode == false:
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
			velocity = Vector2(0,0)
			$AnimatedSprite2D.play("idle-" + facing)
		#move the character and handle collisions
		move_and_slide()

func explode():
	#$PointLight2D.energy = 1.0
	is_dead = true
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D2.visible = true
	$AnimatedSprite2D.visible = false
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D2.play("default")

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_detected = true
		player_in_range = true
	if area.is_in_group("DeadTree1"):
		tree1_in_range = true
	if area.is_in_group("DeadTree2"):
		tree2_in_range = true
	if area.is_in_group("DeadTree3"):
		tree3_in_range = true
	if area.is_in_group("DeadTree4"):
		tree4_in_range = true
	if area.is_in_group("DeadTree5"):
		tree5_in_range = true

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_range = false
	if area.is_in_group("DeadTree1"):
		tree1_in_range = false
	if area.is_in_group("DeadTree2"):
		tree2_in_range = false
	if area.is_in_group("DeadTree3"):
		tree3_in_range = false
	if area.is_in_group("DeadTree4"):
		tree4_in_range = false
	if area.is_in_group("DeadTree5"):
		tree5_in_range = false

func _on_hit_area_area_entered(area: Area2D) -> void:
	#print("in hit area:", area.name, area.get_groups())
	if area.is_in_group("sword"):
		#print("hit by sword")
		health -= globalvariables.sword_damage
		if health <= 0:
			explode()
			await get_tree().create_timer(1.4).timeout
			queue_free()
			var random = round(randf_range(1,3))
			if random == 1:
				var new_object = potion.instantiate()
				get_parent().add_child(new_object)
				new_object.global_position = $Marker2D.global_position
			elif random == 2:
				var new_object = coin.instantiate()
				get_parent().add_child(new_object)
				new_object.global_position = $Marker2D.global_position
			else:
				pass
			globalvariables.monsters_defeated += 1
			if player_in_range == true:
				globalvariables.player_health -= 3
			if tree1_in_range == true:
				burn_tree.emit("DeadTree1")
			if tree2_in_range == true:
				burn_tree.emit("DeadTree2")
			if tree3_in_range == true:
				burn_tree.emit("DeadTree3")
			if tree4_in_range == true:
				burn_tree.emit("DeadTree4")
			if tree5_in_range == true:
				burn_tree.emit("DeadTree5")
	if area.is_in_group("player"):
		globalvariables.player_health -= 1
		globalvariables.hit = true
		player_node.direction = direction
