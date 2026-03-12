extends Node2D

func _ready():
	$CanvasLayer/Label2.text = "Monsters Defeated: " + str(globalvariables.monsters_defeated) +  "\nCoins Collected: " + str(globalvariables.score)
