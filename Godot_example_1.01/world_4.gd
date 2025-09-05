extends StaticBody2D
@onready var box_scene = preload("res://box.tscn")
@onready var spawn_marker = $Marker2D

func _ready():
	spawn_boxes(9)
	
	#A for loop inside a function to randmoly spwn 9 things on the 
func spawn_boxes(count: int):
	for i in range(count):
		#instantiate
		var box_instance = box_scene.instantiate()
		#wait 1 second between ixstantiating.
		await get_tree().create_timer(1).timeout
		#add the instantied item to the game tree at marker 2d
		spawn_marker.add_child(box_instance)
