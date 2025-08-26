extends Area2D

@onready var Score = 0

func _on_body_entered(_body: Node2D) -> void:
	Score += 10
	print(Score)
