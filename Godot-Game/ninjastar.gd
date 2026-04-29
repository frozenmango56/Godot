extends StaticBody2D

var direction = 0
var speed = 40

func _ready():
	var player_node = $"../../player"
	direction = (player_node.global_position - global_position).normalized()

#func _physics_process(delta: float) -> void:
	#velocity = direction * speed
	#
	#move_and_slide()
