extends StaticBody2D
@onready var box_scene = preload("res://orc.tscn")
@onready var spawn_marker = $Marker2D

func _ready():
	spawn_boxes(10)
	
	#A for loop inside a function to randomly spwn 9 things on the 
func spawn_boxes(count: int):
	for i in range(count):
		#instantiate
		var box_instance = box_scene.instantiate()
		#wait 1 second between ixstantiating.
		await get_tree().create_timer(.5).timeout
		#add the instantied item to the game tree at marker 2d
		spawn_marker.add_child(box_instance)
		
