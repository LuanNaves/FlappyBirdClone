extends Node

signal obstacle_created

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
	emit_signal("obstacle_created", obstacle)
	
func start():
	timer.start()

func stop():
	timer.stop()
	
