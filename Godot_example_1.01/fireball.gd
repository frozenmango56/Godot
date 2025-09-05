#########
extends RigidBody2D

@export var speed: float = 500.0
var direction: int = 1   # 1 = right, -1 = left

func _ready() -> void:
	# Give the fireball some initial velocity
	linear_velocity = Vector2(speed * direction, 0)

func _physics_process(delta: float) -> void:
	# Flip sprite depending on velocity
	if linear_velocity.x > 0:
		$Sprite2D.flip_h = false
	elif linear_velocity.x < 0:
		$Sprite2D.flip_h = true

func _on_fireball_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("destroybullet"):
		queue_free()  ## remove bullet from scene
