extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_game_button_down() -> void:
	get_tree().quit()


func _on_resume_button_button_down() -> void:
	get_tree().paused = false
