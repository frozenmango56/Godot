extends StaticBody2D

#func _ready():
#@onready var newlarva = preload("res://larva2.tscn")
#var player_instance = newlarva.instantiate()
##@onready var greenninja = preload("res://greenninja2.tscn")
##@onready var blackninja = preload("res://blackninja.tscn")
##@onready var purpleninja = preload("res://purpleninja2.tscn")
##@onready var spawn_marker = $"."
##
#func _ready():
	#self.add_child(player_instance)
	##instantiate
	#var player = greenninja.instantiate()
	##add the instantied item to the game tree at marker 2d
	#spawn_marker.add_child(player)
	## Remove the node from the old parent
	#$".".remove_child(player)
	## Add the node to the new parent
	#$"..".call_deferred("add_child", player)
