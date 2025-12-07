extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($CharacterBody3D.position)
	print($Camera3D.position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Snap camera to character position
	$Camera3D.position = $CharacterBody3D.position
	
	# Make the camera look at the target point, upright
	$Camera3D.look_at(Vector3(-17, 293.1, 0), Vector3.UP)
	
	# Tilt the camera downward by a certain angle (in radians)
	var tilt_angle = deg_to_rad(-45)  # 20° downward tilt
	$Camera3D.rotate_object_local(Vector3(1, 0, 0), tilt_angle)
	
	# Move the camera back 5 meters along its local -Z axis
	$Camera3D.translate_object_local(Vector3(0, 0, 10))
	if get_node('EndingScreen').visible and Input.is_action_just_pressed("select"):
		get_tree().quit()
