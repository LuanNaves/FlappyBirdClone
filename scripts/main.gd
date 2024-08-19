extends Node2D

@onready var pipe_spawner = $PipeSpawner
@onready var floor = $Floor
@onready var background = $Background
@onready var menu = $Menu
@onready var hud = $HUD

var score = 0: 
	set(new_score):
		score = new_score
		hud.update_score(score)

func _ready():
	pipe_spawner.obstacle_created.connect(_on_obstacle_created)

func _on_obstacle_created(obs):
	obs.score.connect(player_score)

func player_score():
	self.score += 1
	
func new_game():
	score = 0
	pipe_spawner.start()
	
func _on_player_died():
	hud.visible = false
	game_over()

func game_over():
	pipe_spawner.stop()
	floor.stop()
	background.stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	menu.init_game_over_menu(score)

func _on_menu_start_game():
	new_game()

