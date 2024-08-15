extends Node2D

@onready var pipe_spawner = $PipeSpawner
@onready var floor = $Floor
@onready var background = $Background

func _ready():
	new_game()
	
func new_game():
	Global.SCORE = 0
	pipe_spawner.start()	

func _on_player_died():
	game_over()

func game_over():
	pipe_spawner.stop()
	floor.stop()
	background.stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
