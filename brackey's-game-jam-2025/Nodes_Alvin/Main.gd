extends Node2D

signal ProgressChange(n)

@onready var y = 300
@onready var x = -1000
@onready var i = 1

func _on_progress_change(n):
	$ProgressBar.value += n
	#print($ProgressBar.value)

func _on_detect_area_area_entered(area: Area2D) -> void:
	
	#Daughter's Favorites for the Level
	var favType = "Bird"
	var favSize = "Medium"
	var favColour = "Red"
	
	var ball = get_node(area.get_path())
	var totalScore = ball.toyWieght 
	
	#Checking her favorites for each scored toy
	if ball.toySize == favSize:
		totalScore += 5
	
	if ball.toyType == favType:
		totalScore += 5
	
	if ball.toyColour == favColour:
		totalScore += 5
		
	ProgressChange.emit(totalScore)
	
	
	#Moves Toy to Score Area, Maybe uneeded?
	ball.global_position = Vector2(x, y)
	 
	x += 100
	i += 1
	
	if i % 5 == 0:
		x = -1000
		y += 100
	
	print(i , " " , x , " " , y , " " , ball.global_position)
	
	#TO DO Keep track of what toy was obtained and delete the gameobject
		#The color, type, size
	#area.queue_free() #Deletes the game object
		
