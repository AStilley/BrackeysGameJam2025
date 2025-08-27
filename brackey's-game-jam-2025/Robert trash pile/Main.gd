extends Node2D

@onready var Score = 0

signal ProgressChange(Score)

func _on_progress_change(Score):
	$ProgressBar.value += Score
	print($ProgressBar.value)

func _on_detect_area_body_entered(body):
	var ball = get_node(body.get_path())
	Score += ball.toyWieght
	print(Score)
	ProgressChange.emit(Score)
