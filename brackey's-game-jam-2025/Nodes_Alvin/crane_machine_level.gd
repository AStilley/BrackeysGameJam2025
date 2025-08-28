extends Node2D
var tokens



signal insertToken
#insertToken.emit()

#The player has a certain amount of tokens,
	#They spend a token to use the claw machine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_tokens()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func reset_tokens():
	tokens = 10
