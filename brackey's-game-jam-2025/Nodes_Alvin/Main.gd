extends Node2D

signal ProgressChange(n)
signal levelComplete
@onready var y = 300
@onready var x = -1000

var toyTypeList = ["Bird", "Cat", "Dog", "Frog", "Gorilla", "Monkey"]
var sizeTypeList = ["Small", "Medium", "Large"]
var colorTypeList = ["Blue", "Green", "Purple", "Red", "Yellow"]
var favType = toyTypeList.pick_random()
var favSize = sizeTypeList.pick_random()
var favColour = colorTypeList.pick_random()
var progress
signal favoriteToy(favType,favSize, favColour)
signal checkTokens
func _ready() -> void:
	resetFavorites()


func _on_progress_change(n):
	$ProgressBar.value += n
	if $ProgressBar.value >= $ProgressBar.max_value:
		$ProgressBar.value = 0
		levelComplete.emit()
		resetFavorites()
	else:
		checkTokens.emit()
	#print($ProgressBar.value)
func resetFavorites():
	favType = toyTypeList.pick_random()
	favSize = sizeTypeList.pick_random()
	favColour = colorTypeList.pick_random()
	favoriteToy.emit(favType,favSize, favColour)
	print("Favorite Type: ", favType)
	print("Favorite Size: ", favSize)
	print("Favorite Color: ", favColour)
func _on_detect_area_area_entered(area: Area2D) -> void:
	
	#Daughter's Favorites for the Level
	#var favType = "Bird"
	#var favSize = "Medium"
	#var favColour = "Red"
	#$SoundEffects.set_stream("res://Gabe Assets/413629__djlprojects__video-game-sfx-positive-action-long-tail.wav")
	$SoundEffects.play()
	var ball = get_node(area.get_path())
	var totalScore = ball.toyWieght 
	
	#Checking her favorites for each scored toy
	if ball.toySize == favSize:
		totalScore += 10
	
	if ball.toyType == favType:
		totalScore += 10
	
	if ball.toyColour == favColour:
		totalScore += 10
		
	var crane = get_node($"../Crane".get_path())
	
	Globals.ScoredToysColour.append(ball.toyColour)
	print(Globals.ScoredToysColour)
	Globals.ScoredToysSize.append(ball.toySize)
	print(Globals.ScoredToysSize)
	Globals.ScoredToysType.append(ball.toyType)
	print(Globals.ScoredToysType)
	Globals.i += 1
	
	if crane.currentCraneType == "Gold":
		ProgressChange.emit(totalScore*2)
	else:
		ProgressChange.emit(totalScore)
	
		#print(Globals.i)
		#Used to create the next new toy
	ball.resetPosition()
	##Moves Toy to Score Area, Maybe uneeded?
	#ball.global_position = Vector2(x, y)
	 #
	#x += 100
	#i += 1
	#
	#if i % 5 == 0:
		#x = -1000
		#y += 100
	#
	#print(i , " " , x , " " , y , " " , ball.global_position)
	
	#TO DO Keep track of what toy was obtained and delete the gameobject
		#The color, type, size
	#area.queue_free() #Deletes the game object
		
func resetProgressBar(level):
	match Globals.LevelCount:
		1:
			$ProgressBar.texture_progress = load("res://Assets_Alvin/Sprites/Hearts/Heart_1.png")
		2:
			$ProgressBar.texture_progress = load("res://Assets_Alvin/Sprites/Hearts/Heart_2.png")
		3:
			$ProgressBar.texture_progress = load("res://Assets_Alvin/Sprites/Hearts/Heart_3.png")
	$ProgressBar.value = 0
	$ProgressBar.max_value = 75 * level
	pass
