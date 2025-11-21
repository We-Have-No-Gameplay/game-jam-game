extends Control

var level_shown = false
var paused = false
var mainMenu_shown = false
var mainMenubuttonsForSelection = ["MainMenu/PlayButton","MainMenu/CreditsButton"] # should contain all buttons in order from top to bottom
var mainMenubuttonSelectedIndex = 0
signal playButtonPressed
signal pausePressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenu/ButtonSelectors.hide()
	$MainMenu/ButtonSelectors.position.y = $MainMenu/PlayButton.position.y
	$MainMenu/ButtonSelectors.show()
	
func moveButtonsToNodeY(selection,index):
	$MainMenu/ButtonSelectors.position.y = get_node(selection[index]).position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("arrow_down") and mainMenu_shown: # if we are navigating the HUD
		mainMenubuttonSelectedIndex += 1
		mainMenubuttonSelectedIndex = mainMenubuttonSelectedIndex % len(mainMenubuttonsForSelection)
		moveButtonsToNodeY(mainMenubuttonsForSelection,mainMenubuttonSelectedIndex)
	elif Input.is_action_just_pressed("arrow_up") and mainMenu_shown:
		mainMenubuttonSelectedIndex -= 1
		mainMenubuttonSelectedIndex = mainMenubuttonSelectedIndex % len(mainMenubuttonsForSelection)
		moveButtonsToNodeY(mainMenubuttonsForSelection,mainMenubuttonSelectedIndex)
	elif Input.is_action_just_pressed("select") and mainMenu_shown:
		if mainMenubuttonsForSelection[mainMenubuttonSelectedIndex] == "PlayButton":
			playButtonPressed.emit()
	if Input.is_action_just_pressed("escape") and level_shown:
		pausePressed.emit()

func _on_main_level_shown() -> void:
	level_shown = true
	paused = false
	mainMenu_shown = false
	$MainMenu.hide()
	$PauseMenu.hide()

func _on_main_main_menu_shown() -> void:
	mainMenu_shown = true
	level_shown = false
	paused = false
	$MainMenu.show()
	$PauseMenu.hide()

func _on_main_paused() -> void:
	paused = true
	mainMenu_shown = false
	level_shown = false
	$MainMenu.hide()
	$PauseMenu.show()
