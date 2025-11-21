extends Control

var level_shown = false
var paused = false
var mainMenu_shown = false
var buttonsForSelection = ["PlayButton","CreditsButton"] # should contain all buttons in order from top to bottom
var buttonSelectedIndex = 0
signal playButtonPressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ButtonSelectors.hide()
	$ButtonSelectors.position.y = $PlayButton.position.y
	$ButtonSelectors.show()
	
func moveButtonsToNodeY(selection,index):
	$ButtonSelectors.position.y = get_node(selection[index]).position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("arrow_down") and mainMenu_shown: # if we are navigating the HUD
		buttonSelectedIndex += 1
		buttonSelectedIndex = buttonSelectedIndex % len(buttonsForSelection)
		moveButtonsToNodeY(buttonsForSelection,buttonSelectedIndex)
	elif Input.is_action_just_pressed("arrow_up") and mainMenu_shown:
		buttonSelectedIndex -= 1
		buttonSelectedIndex = buttonSelectedIndex % len(buttonsForSelection)
		moveButtonsToNodeY(buttonsForSelection,buttonSelectedIndex)
	elif Input.is_action_just_pressed("select") and mainMenu_shown:
		if buttonsForSelection[buttonSelectedIndex] == "PlayButton":
			playButtonPressed.emit()

func _on_main_level_shown() -> void:
	level_shown = true
	paused = false
	mainMenu_shown = false

func _on_main_main_menu_shown() -> void:
	mainMenu_shown = true
	level_shown = false
	paused = false

func _on_main_paused() -> void:
	paused = true
	mainMenu_shown = false
	level_shown = false
