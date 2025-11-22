extends Control

#Variables
#Booleans
var level_shown = false
var paused = false
var mainMenu_shown = false
#Lists
var mainMenubuttonsForSelection = ["MainMenu/ButtonsContainer/PlayButton","MainMenu/ButtonsContainer/CreditsButton","MainMenu/ButtonsContainer/ExitGameButton"] # should contain all main menu buttons in order from top to bottom
var pauseMenubuttonsForSelection = ["PauseMenu/ResumeButton","PauseMenu/OptionsButton","PauseMenu/ExitToMenuButton","PauseMenu/ExitGameButton"] # should contain all pause menu buttons in order from top to bottom
#Integers
var mainMenubuttonSelectedIndex = 0
var pauseMenubuttonSelectedIndex = 0

#Signals
signal playButtonPressed
signal creditsButtonPressed
signal pausePressed
signal exitGameButtonPressed
signal resumeButtonPressed
signal exitToMenuButtonPressed
signal optionsButtonPressed

#Main Code:
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenu/ButtonSelectors.hide()
	$MainMenu/ButtonSelectors.position.y = $MainMenu/ButtonsContainer/PlayButton.position.y + get_node('MainMenu/ButtonsContainer').position.y #Calculates the global height of the buttons
	$MainMenu/ButtonSelectors.show()
	
	#Set booleans to correct values
	if get_node('MainMenu').is_visible_in_tree():
		mainMenu_shown = true
	elif get_node('PauseMenu').is_visible_in_tree():
		paused = true
	elif false:
		#Replace this with any other checks to set booleans
		pass
	else:
		level_shown = true
	
func moveMainButtonsToNodeY(selection,index):
	$MainMenu/ButtonSelectors.position.y = get_node(selection[index]).position.y + get_node('MainMenu/ButtonsContainer').position.y #Calculates the global height of the buttons
func movePauseButtonsToNodeY(selection,index):
	$PauseMenu/ButtonSelector.position.y = get_node(selection[index]).position.y #Calculates the global height of the buttons
	$PauseMenu/ButtonSelector.position.x = get_node(selection[index]).position.x - 29 #Calculates the necessary x position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if mainMenu_shown: #If we are on the MainMenu
		if Input.is_action_just_pressed("arrow_down"):
			mainMenubuttonSelectedIndex += 1
			mainMenubuttonSelectedIndex = mainMenubuttonSelectedIndex % len(mainMenubuttonsForSelection)
			moveMainButtonsToNodeY(mainMenubuttonsForSelection,mainMenubuttonSelectedIndex)
		elif Input.is_action_just_pressed("arrow_up"):
			mainMenubuttonSelectedIndex -= 1
			mainMenubuttonSelectedIndex = mainMenubuttonSelectedIndex % len(mainMenubuttonsForSelection)
			moveMainButtonsToNodeY(mainMenubuttonsForSelection,mainMenubuttonSelectedIndex)
		elif Input.is_action_just_pressed("select"):
			if mainMenubuttonsForSelection[mainMenubuttonSelectedIndex] == "MainMenu/ButtonsContainer/PlayButton":
				playButtonPressed.emit()
				print('playButtonPressed')
				level_shown = true
				mainMenu_shown = false
				get_node('MainMenu').hide()
			elif mainMenubuttonsForSelection[mainMenubuttonSelectedIndex] == "MainMenu/ButtonsContainer/CreditsButton":
				creditsButtonPressed.emit()
				print('creditsButtonPressed')
			elif mainMenubuttonsForSelection[mainMenubuttonSelectedIndex] == "MainMenu/ButtonsContainer/ExitGameButton":
				exitGameButtonPressed.emit()
				print('exitGameButtonPressed')
				get_tree().quit()
			
		
	
	elif paused: #If we are on the pause menu
		if Input.is_action_just_pressed("escape"):
			resumeButtonPressed.emit()
			print('resumePressed')
			level_shown = true
			paused = false
			get_node('PauseMenu').hide()
		if Input.is_action_just_pressed("arrow_down"):
			pauseMenubuttonSelectedIndex += 1
			pauseMenubuttonSelectedIndex = pauseMenubuttonSelectedIndex % len(pauseMenubuttonsForSelection)
			movePauseButtonsToNodeY(pauseMenubuttonsForSelection,pauseMenubuttonSelectedIndex)
		elif Input.is_action_just_pressed("arrow_up"):
			pauseMenubuttonSelectedIndex -= 1
			pauseMenubuttonSelectedIndex = pauseMenubuttonSelectedIndex % len(pauseMenubuttonsForSelection)
			movePauseButtonsToNodeY(pauseMenubuttonsForSelection,pauseMenubuttonSelectedIndex)
		elif Input.is_action_just_pressed("select"):
			if pauseMenubuttonsForSelection[pauseMenubuttonSelectedIndex] == "PauseMenu/ResumeButton":
				resumeButtonPressed.emit()
				print('resumeButtonPressed')
				level_shown = true
				paused = false
				get_node('PauseMenu').hide()
			elif pauseMenubuttonsForSelection[pauseMenubuttonSelectedIndex] == "PauseMenu/OptionsButton":
				optionsButtonPressed.emit()
				print('optionsButtonPressed')
			elif pauseMenubuttonsForSelection[pauseMenubuttonSelectedIndex] == "PauseMenu/ExitToMenuButton":
				exitToMenuButtonPressed.emit()
				print('exitToMenuButtonPressed')
				paused = false
				mainMenu_shown = true
				get_node('MainMenu').show()
				get_node('PauseMenu').hide()
			elif pauseMenubuttonsForSelection[pauseMenubuttonSelectedIndex] == "PauseMenu/ExitGameButton":
				exitGameButtonPressed.emit()
				print('exitGameButtonPressed')
				get_tree().quit()
			
		
	elif level_shown:
		if Input.is_action_just_pressed("escape"):
			pausePressed.emit()
			print('pausePressed')
			level_shown = false
			paused = true
			get_node('PauseMenu').show()
		
	

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
