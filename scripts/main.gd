extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide the main level
	get_node("Level").hide()
	
	# Show the HUD
	get_node("HUD").show()
	
	# Connecting the PlayButton
	var playButton = get_node("HUD/PlayButton") # Gets the PlayButton node from HUD
	playButton.pressed.connect(_on_play_button_pressed) # Connects the 'pressed' signal into this script


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	# When PlayButton pressed, show the level
	get_node("HUD").hide() ## Note: this will need to be changed in future - HUD elements will need to be shown, and this should only selectively hide the level selector etc.
	get_node("Level").show()
