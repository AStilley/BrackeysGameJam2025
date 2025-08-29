extends Node2D

var level
signal nextLevel
signal gameOverScreen
var levelCompleted = false
#The player has a certain amount of tokens,
	#They spend a token to use the claw machine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 1
	$Crane.gameOver.connect(GoGameOverScreen)	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func GoGameOverScreen():
	#await get_tree().create_timer(1).timeout
	if !levelCompleted:
		gameOverScreen.emit()
		print("Level was not completed, game over")
	else:
		print("Level was completed, avoided game over")
func fullReset():
	level = 1
	restartLevel()
func restartLevel():
	print("test")
	$Crane.craneReset()
	$ToyDetect.resetProgressBar(level)
	get_tree().call_group("Toy","resetPosition")
	levelCompleted = false
func _on_toy_detect_level_complete() -> void:
	levelCompleted = true
	level += 1
	restartLevel()
	print(level)
	nextLevel.emit()

	#main screen should move over 1 screen to the collection screen
	pass # Replace with function body.
