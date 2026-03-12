extends Node2D

@onready var greenninja = preload("res://greenninja.tscn")
#@onready var blackninja = preload("res://blackninja.tscn")
@onready var purpleninja = preload("res://purpleninja.tscn")

var facing = "down"
var faceset = "Monsters/Eye"
var playertype = greenninja
var spawn_position = Vector2(3335,-148)
var weapons_list = []
var player_health = 8
var max_player_health = 8
var score = 0
var hit = false
var hit_again = true
var monsters_defeated = 0
var sand_defeated = 0
