extends Node

@onready var timer = $Timer
var PIPE = preload("res://scenes/pipe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	

func _on_timer_timeout():
	spawn_pipes()

func spawn_pipes():
	var pipe = PIPE.instance()
	add_child(pipe)
	pipe.position.y = randi() % 450 + 150
	
