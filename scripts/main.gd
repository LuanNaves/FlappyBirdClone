extends Node2D

@onready var pipe_spawner = $PipeSpawner
@onready var floor = $Floor
@onready var background = $Background
@onready var menu = $Menu
@onready var hud = $HUD
var highscore = 0

const SAVE_FILE_PATH = "user://savedata.save"

var score = 0: 
	set(new_score):
		score = new_score
		hud.update_score(score)

func _ready():
	pipe_spawner.obstacle_created.connect(_on_obstacle_created)
	load_highscore()

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
	
	if score > highscore:
		highscore = score
		save_highscore()
		
	menu.init_game_over_menu(score, highscore)

func _on_menu_start_game():
	new_game()
	
func save_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	var file_exist = FileAccess.file_exists(SAVE_FILE_PATH)
	if file_exist:
		var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		highscore = save_data.get_var()
		save_data.close()
	

