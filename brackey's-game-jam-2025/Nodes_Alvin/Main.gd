extends Node2D

signal ProgressChange(n)

func _on_progress_change(n):
	$ProgressBar.value += n
	#print($ProgressBar.value)

func _on_detect_area_area_entered(area: Area2D) -> void:
	var ball = get_node(area.get_path())
	var totalScore = ball.toyWieght #+ favored toy, + size 
	ProgressChange.emit(totalScore)
	#TO DO Keep track of what toy was obtained and delete the gameobject
		#The color, type, size
	#area.queue_free() #Deletes the game object
		
