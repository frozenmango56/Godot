extends PathFollow2D
var speed = 2

func _physics_process(delta: float) -> void:
	progress_ratio += delta * speed
