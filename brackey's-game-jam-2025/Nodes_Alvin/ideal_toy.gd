extends Sprite2D
# Called when the node enters the scene tree for the first time.

signal forceExistence(type,size,toyColor,num)
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toy_detect_favorite_toy(type,size,toyColour) -> void:
	match size:
		"Small":
			scale = Vector2(0.125,0.125)
		"Medium":
			scale = Vector2(0.25,0.25)
		"Large":
			scale = Vector2(0.50,0.50)/2
	match type:
		"Bird":
			match toyColour: 
				"Blue":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-bklue.png')
				"Green":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-green.png')
				"Purple":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-purple.png')
				"Red":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-red.png')
				"Yellow":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-yellow.png')													
		"Cat":
			match toyColour: 
				"Blue":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-blue.png')
				"Green":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-green.png')
				"Purple":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-purple.png')
				"Red":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-red.png')
				"Yellow":
					texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-yellow.png')
		"Dog":
			match toyColour: 
				"Blue":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-blue.png")
				"Green":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-green.png")
				"Purple":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-purple.png")
				"Red":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-red.png")
				"Yellow":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-yellow.png")		
		"Frog":
			match toyColour: 
				"Blue":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-blue.png")
				"Green":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-green.png")
				"Purple":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-purple.png")
				"Red":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-red.png")
				"Yellow":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-yellow.png")		
		"Gorilla":
			match toyColour: 
				"Blue":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-blue.png")
				"Green":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-green.png")
				"Purple":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-purple.png")
				"Red":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-red.png")	
				"Yellow":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-yellow.png")	
		"Monkey":
			match toyColour: 
				"Blue":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-blue.png")
				"Green":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-green.png")
				"Purple":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-purple.png")
				"Red":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-red.png")
				"Yellow":
					texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-yellow.png")
	forceExistence.emit(type,size,toyColour,randi_range(1,5))
