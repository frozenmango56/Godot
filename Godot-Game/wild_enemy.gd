extends CharacterBody2D

var speed = 70
@onready var sprite = $AnimatedSprite2D
var health = 3
var facing = "down"
var direction = Vector2(0,0)
var repetions_before_break = round(randf_range(3,5))
var repetions = 0
var rd = 0
var stop = false
	
func random_direction():
	if stop == false:
		repetions += 1
		var random = round(randf_range(1,4))
		if repetions_before_break == repetions:
			repetions = 0
			repetions_before_break = round(randf_range(3,5))
			direction = Vector2(0,0)
			$AnimatedSprite2D.play("idle-down")
		elif random==1:
			direction.y -= 1
			$AnimatedSprite2D.play("walk-up")
		elif random == 2:
			direction.y += 1
			$AnimatedSprite2D.play("walk-down")
		elif random == 3:
			direction.x -= 1
			$AnimatedSprite2D.play("walk-left")
		elif random == 4:
			direction.x += 1
			$AnimatedSprite2D.play("walk-right")
	elif stop == true:
		direction = Vector2(0,0)
		$AnimatedSprite2D.play("idle-down")
		$Timer.stop()
		print("wha")

func _on_timer_timeout() -> void:
	rd += 1
	print(rd)
	direction = Vector2(0,0)
	random_direction()

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		stop = true
		
func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		stop = false
		$Timer.start()
		random_direction()
	

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()

func _on_hit_area_area_entered(area: Area2D) -> void:
	#print("in hit area:", area.name, area.get_groups())
	if area.is_in_group("sword"):
		health -= 1
		if health <= 0:
			queue_free()
	if area.is_in_group("player"):
		globalvariables.player_health -= 1
		#print(globalvariables.player_health)
		# Get the CharacterBody2D that owns this Area2D
		var player := area.get_parent() as CharacterBody2D
		if player:
			var direction = (player.global_position - global_position).normalized()
			player.global_position += direction * 40  # 40 = knockback distance
