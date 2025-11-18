extends Marker2D

@onready var greenninja = preload("res://greenninja2.tscn")
@onready var blackninja = preload("res://blackninja.tscn")
@onready var purpleninja = preload("res://purpleninja.tscn")
@onready var spawn_marker = $"."

func _ready():
	#instantiate
	var player = greenninja.instantiate()
	#add the instantied item to the game tree at marker 2d
	spawn_marker.add_child(player)
