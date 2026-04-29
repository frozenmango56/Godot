extends CharacterBody2D

var speed = 70
@onready var sprite = $AnimatedSprite2D
var health = 3
var facing = "down"
var direction = Vector2(0,0)
var repetions_before_break = round(randf_range(3,5))
var repetions = 0
var stop = false
var player_node: Node2D = null
@onready var potion = preload("res://health_potion.tscn")
@onready var coin = preload("res://coin.tscn")
	
func random_direction():
	if stop == false:
		repetions += 1
		var random = round(randf_range(1,4))
		if repetions_before_break == repetions:
			repetions = 0
			repetions_before_break = round(randf_range(3,5))
			direction = Vector2(0,0)
			$AnimatedSprite2D.play("idle-" + facing)
		elif random==1:
			direction.y -= 1
			$AnimatedSprite2D.play("walk-up")
			facing = "up"
		elif random == 2:
			direction.y += 1
			$AnimatedSprite2D.play("walk-down")
			facing = "down"
		elif random == 3:
			direction.x -= 1
			$AnimatedSprite2D.play("walk-left")
			facing = "left"
		elif random == 4:
			direction.x += 1
			$AnimatedSprite2D.play("walk-right")
			facing = "right"
	elif stop == true:
		direction = Vector2(0,0)
		$AnimatedSprite2D.play("idle-down")
		$Timer.stop()

func _on_timer_timeout() -> void:
	direction = Vector2(0,0)
	random_direction()

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		stop = true
		
func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_node = $"../player"
		stop = false
		$Timer.start()
		random_direction()
	

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()

func _on_hit_area_area_entered(area: Area2D) -> void:
	#print("in hit area:", area.name, area.get_groups())
	if area.is_in_group("sword"):
		health -= globalvariables.sword_damage
		if health <= 0:
			queue_free()
			globalvariables.monsters_defeated += 1
			var random = round(randf_range(1,2))
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
	if area.is_in_group("player"):
		globalvariables.player_health -= 1
		globalvariables.hit = true
		player_node.direction = direction
