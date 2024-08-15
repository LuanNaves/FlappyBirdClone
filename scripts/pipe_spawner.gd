extends Node

@onready var timer = $Timer
const OBSTACLE = preload("res://scenes/obstacle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _on_timer_timeout():
	spawn_pipes()

func spawn_pipes():
	var obstacle = OBSTACLE.instantiate()
	add_child(obstacle)
	obstacle.position.y = randi_range(100, 320)
	
func start():
	timer.start()

func stop():
	timer.stop()
	
