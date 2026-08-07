extends CharacterBody2D

var speed = 50.0
@onready var sprite = $AnimatedSprite2D
@onready var potion = preload("res://health_potion.tscn")
@onready var coin = preload("res://coin.tscn")
var health = 5
var facing = "down"
var direction = Vector2(1,0)
var player_direction = Vector2(0,0)
var repetions_before_break = round(randf_range(3,5))
var repetions = 0
var player_node: Node2D = null
var invincible = true

func charge():
	print("charge")

func _physics_process(delta: float) -> void:
	player_node = $"../player"
	player_direction = (player_node.global_position - global_position).normalized()
	velocity = direction * speed
	$AnimatedSprite2D.play("idle")
	move_and_slide()

func _on_hit_area_area_entered(area: Area2D) -> void:
	#print("in hit area:", area.name, area.get_groups())
	if area.is_in_group("sword") and invincible == false:
		health -= globalvariables.sword_damage
		if health <= 0:
			queue_free()
			globalvariables.monsters_defeated += 1
	elif area.is_in_group("player"):
		globalvariables.player_health -= 4
		globalvariables.hit = true
		player_node.direction = player_direction
	else:
		pass
