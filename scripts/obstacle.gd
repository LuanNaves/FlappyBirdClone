extends Node2D

signal score

var SPEED = 100

func _ready():
	position.x = 300
	
func _physics_process(delta):
	position.x -= SPEED * delta
	if global_position.x < -100:
		queue_free()

func _on_pipe_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_score_area_body_exited(body):
	if body is Player:
		emit_signal("score")

