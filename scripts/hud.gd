extends CanvasLayer

@onready var score_label = $Score

func _process(delta):
	score_label.text = str(Global.SCORE)
