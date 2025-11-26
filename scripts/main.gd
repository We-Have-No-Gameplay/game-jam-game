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

var masterVolume = 50

signal paused
signal resumed
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
	
	# Connect timing signals to children
	self.paused.connect($LevelContainer/LevelSubViewport/Level/CharacterBody3D._on_main_paused)
	self.resumed.connect($LevelContainer/LevelSubViewport/Level/CharacterBody3D._on_main_resumed)
	self.level_shown.connect($LevelContainer/LevelSubViewport/Level/CharacterBody3D._on_main_resumed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_hud_play_button_pressed() -> void:
	level_shown.emit()
	$LevelContainer.show()

func _on_hud_pause_pressed() -> void:
	paused.emit()
	$LevelContainer.hide()


func _on_hud_resume_button_pressed() -> void:
	resumed.emit()
	$LevelContainer.show()

func _on_hud_master_volume_changed(volume: float) -> void:
	masterVolume = volume
	print('volumeUpdated')
