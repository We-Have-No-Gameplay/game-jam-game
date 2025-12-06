extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($CharacterBody3D.position)
	print($Camera3D.position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera3D.position.x = $CharacterBody3D.position.x + 25
	$Camera3D.position.y = $CharacterBody3D.position.y + 17
	$Camera3D.position.z = $CharacterBody3D.position.z + 25
	
