extends Node2D

func _ready():
	$CanvasLayer/Label2.text = "Monsters Defeated: " + str(globalvariables.monsters_defeated) +  "\nCoins Collected: " + str(globalvariables.coins_collected)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Space"):
		globalvariables.facing = "down"
		globalvariables.coins_collected = 0
		globalvariables.monsters_defeated = 0
		globalvariables.spawn_position = Vector2(3335,-148)
		globalvariables.sword_damage = 1
		get_tree().call_deferred("change_scene_to_file", "res://start.tscn")
