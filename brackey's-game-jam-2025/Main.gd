extends Area2D

@onready var Score = 0

func _on_body_entered(_body: Node2D) -> void:
	var ball = get_node(_body.get_path())
	Score += ball.toyWieght
	print(Score)
	
	
