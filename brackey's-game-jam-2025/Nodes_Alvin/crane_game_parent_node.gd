extends Node2D
@onready var crane_machine_level: Node2D = $CraneMachineLevel
@onready var main: Node2D = $Main
@onready var score_and_collection: Node2D = $ScoreAndCollection
@onready var game_over: Node2D = $"Game Over"

signal ScoreToy(size, type, toyColour)

var screen = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Screen test")
	$"Scene Themes".set_stream(load("res://Assets_Alvin/sounds/Main Menu.mp3"))
	$"Scene Themes".play()
	
	mainMenuOn()
	craneMachineOff()
	score_and_collectionOff()
	gameOverOff()
	gameWinOff()
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
			gameWinOff()
			$"Scene Themes".set_stream(load("res://Assets_Alvin/sounds/Main Menu.mp3"))
			$"Scene Themes".play()
			pass
		2:
			#Whatever the current level is
			craneMachineOn()
			mainMenuOff()
			score_and_collectionOff()
			gameOverOff()
			gameWinOff()
			$"Scene Themes".set_stream(load("res://Assets_Alvin/sounds/Gameplay.wav"))
			$"Scene Themes".play()
			pass
		3:
			#Whatever the current level is
			score_and_collectionOn()
			craneMachineOff()
			mainMenuOff()
			gameOverOff()
			gameWinOff()
			$"Scene Themes".set_stream(load("res://Assets_Alvin/sounds/Collected.wav"))
			$"Scene Themes".play()
			pass
		4:
			screen = 1
			switchToScreen()
			
		5: #game over
			gameWinOff()
			#print("game over")
			gameOverOn()
			#craneMachineOff()
			mainMenuOff()
			score_and_collectionOff()
			$"Scene Themes".set_stream(load("res://Assets_Alvin/sounds/GameEnd.mp3"))
			$"Scene Themes".play()
			
		6: #Game Win
			print("game win")
			gameWinOn()
			gameOverOff()
			craneMachineOff()
			mainMenuOff()
			score_and_collectionOff()
			$"Scene Themes".set_stream(load("res://Assets_Alvin/sounds/GameEnd.mp3"))
			$"Scene Themes".play()
			
			
func gameWinOn():
	$GameEnd.visible = true
	$GameEnd.set_process(true)
func gameWinOff():
	$GameEnd.visible = false
	$GameEnd.set_process(false)
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
	
	var listOfScoreToys = get_tree().get_nodes_in_group("ScoredToy")
	get_tree().call_group("ScoredToy", "PrizeInvisible")
	if Globals.i >15:
		Globals.i = 15
	for n in Globals.i:
		listOfScoreToys[n]._on_crane_game_parent_node_score_toy(Globals.ScoredToysType[n],Globals.ScoredToysSize[n],Globals.ScoredToysColour[n])
	#listOfScoreToys[Globals.i]._on_crane_game_parent_node_score_toy(Globals.ScoredToysType[Globals.i],Globals.ScoredToysSize[Globals.i],Globals.ScoredToysColour[Globals.i])
		
		#var node = get_node("Score Toy" + str(Globals.x + 1))
		#ScoreToy.emit()
		
	print("Die Lock")
		
	
func score_and_collectionOff():
	score_and_collection.visible = false
	score_and_collection.set_process(false)
	Globals.ScoredToysType = []
	Globals.ScoredToysSize = []
	Globals.ScoredToysColour = []
	Globals.i = 0
func gameOverOn():
	game_over.visible = true
	game_over.set_process(true)
	Globals.ScoredToysType = []
	Globals.ScoredToysSize = []
	Globals.ScoredToysColour = []
	Globals.i = 0
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
	
	


func _on_next_2_button_down():
	if Globals.LevelCount == 4:
		screen = 6
	else:
		screen = 2
	switchToScreen()
	pass # Replace with function body.


func _on_button_pressed():
	#Winning End Button
	$CraneMachineLevel.fullReset()
	screen = 1
	switchToScreen()
	pass # Replace with function body.


func _on_scene_themes_finished():
	$"Scene Themes".play()
	pass # Replace with function body.
