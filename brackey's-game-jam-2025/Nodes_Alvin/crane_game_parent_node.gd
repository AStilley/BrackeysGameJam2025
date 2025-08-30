extends Node2D
@onready var crane_machine_level: Node2D = $CraneMachineLevel
@onready var main: Node2D = $Main
@onready var score_and_collection: Node2D = $ScoreAndCollection
@onready var game_over: Node2D = $"Game Over"



var screen = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Screen test")
	mainMenuOn()
	craneMachineOff()
	score_and_collectionOff()
	gameOverOff()
	$CraneMachineLevel.nextLevel.connect(nextscreen)
	$CraneMachineLevel.gameOverScreen.connect(GameOverMenu)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_screen_change"):
		screen += 1
		print(screen)
		switchToScreen()

func switchToScreen():
	match screen:
		0:
			screen = 3
			switchToScreen()
		1:
			mainMenuOn()
			craneMachineOff()
			score_and_collectionOff()
			gameOverOff()
			pass
		2:
			#Whatever the current level is
			craneMachineOn()
			mainMenuOff()
			score_and_collectionOff()
			gameOverOff()
			pass
		3:
			#Whatever the current level is
			score_and_collectionOn()
			craneMachineOff()
			mainMenuOff()
			gameOverOff()
			pass
		4:
			screen = 1
			switchToScreen()
		5: #game over
			#print("game over")
			gameOverOn()
			craneMachineOff()
			mainMenuOff()
			score_and_collectionOff()
func craneMachineOn():
	crane_machine_level.visible = true
	crane_machine_level.set_process(true)
func craneMachineOff():
	crane_machine_level.visible = false
	crane_machine_level.set_process(false)
func mainMenuOn():
	main.visible = true
	main.set_process(true)
func mainMenuOff():
	main.visible = false
	main.set_process(false)
func score_and_collectionOn():
	score_and_collection.visible = true
	score_and_collection.set_process(true)
func score_and_collectionOff():
	score_and_collection.visible = false
	score_and_collection.set_process(false)
func gameOverOn():
	game_over.visible = true
	game_over.set_process(true)
func gameOverOff():
	game_over.visible = false
	game_over.set_process(false)
func GameOverMenu():
	screen = 5
	switchToScreen()
func _on_start_pressed() -> void:
	nextscreen()
	pass # Replace with function body.
func nextscreen():
	screen+= 1
	switchToScreen()


func _on_button_button_down() -> void:
	screen = 2
	switchToScreen()
	pass # Replace with function body.


func _on_main_menu_button_down() -> void:
	$CraneMachineLevel.fullReset()
	screen = 1
	switchToScreen()
	pass # Replace with function body.


func _on_retry_button_down() -> void:
	$CraneMachineLevel.restartLevel()
	screen = 2
	switchToScreen()
	pass # Replace with function body.
