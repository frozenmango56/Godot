extends CharacterBody2D
	
@export var projectile = preload("res://ninjastar.tscn")
@export var speed = 50.0
@onready var sprite = $AnimatedSprite2D
var facing = "down"
#this variable will hold the reference to the player node once its detected
var player_node: Node2D = null

#A boolean to track if the player has entered the detection area
var player_detected = false
func _ready():
	player_node = $"../player"

func _physics_process(delta: float) -> void:
	var direction = (player_node.global_position - global_position).normalized()
	#set velocity
	if direction.x > abs(direction.y):
		$AnimatedSprite2D.play("idle-right")
		facing = "right"
	elif direction.x < abs(direction.y) * -1:
		$AnimatedSprite2D.play("idle-left")
		facing = "left"
	elif direction.y > 0:
		$AnimatedSprite2D.play("idle-down")
		facing = "down"
	elif direction.y < 0:
		$AnimatedSprite2D.play("idle-up")
		facing = "up"

func attack():
	print("Attack")

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_detected = true
		attack()

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_detected = false
