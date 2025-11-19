""" Copyright (C) 2025 We Have No Gameplay (HippoProgrammer, DrygithTheGM, Goldenfootie)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>."""

extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Print licensing information (this should also be added to credits when able)
	print("A Game about Something (main.gd)  Copyright (C) 2025 We Have No Gameplay (HippoProgrammer, DrygithTheGM, Goldenfootie)")
	print("This program comes with ABSOLUTELY NO WARRANTY.")
	print("This is free software, and you are welcome to redistribute it")
	print("under certain conditions.")

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
