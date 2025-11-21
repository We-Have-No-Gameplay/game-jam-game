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

signal paused
signal level_shown
signal mainMenu_shown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Print licensing information (this should also be added to credits when able)
	print("A Game about Something (main.gd)  Copyright (C) 2025 We Have No Gameplay (HippoProgrammer, DrygithTheGM, Goldenfootie)")
	print("This program comes with ABSOLUTELY NO WARRANTY.")
	print("This is free software, and you are welcome to redistribute it")
	print("under certain conditions.")

	# Hide the main level
	$LevelContainer.hide()
	$TestThingyContainer.hide()
	
	# Show the HUD
	$HUD.show()
	mainMenu_shown.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_hud_play_button_pressed() -> void:
	level_shown.emit()

func _on_hud_pause_pressed() -> void:
	paused.emit()
