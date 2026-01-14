extends Node2D

@onready var greenninja = preload("res://greenninja2.tscn")
@onready var blackninja = preload("res://blackninja.tscn")
@onready var purpleninja = preload("res://purpleninja2.tscn")

var facing = "down"
var faceset = "Monsters/Eye"
var playertype = greenninja
var spawn_position = Vector2(3335,-148)
var weapons_list = []
var player_health = 10
var score = 0
