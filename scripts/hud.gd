extends Control

var level_shown = false
var paused = false
var mainMenu_shown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("arrow_down") and mainMenu_shown: # if we are navigating the HUD
		pass
	elif Input.is_action_just_pressed("arrow_up") and mainMenu_shown:
		pass


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
