extends CharacterBody2D

@export var speed = 40
var player_node: Node2D = null
#A boolean to track if the player has entered the detection area
var player_detected = false

func _ready():
	player_node = $"../player"

func _physics_process(delta: float) -> void:
	if player_detected == true:
		var direction = (player_node.global_position - global_position).normalized()
		velocity = direction * speed
	elif player_detected == false:
		$AnimatedSprite2D.play("idle")
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_detected = true
