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

extends CharacterBody3D

@onready var cam: Camera3D = get_parent().get_node("Camera3D")
@onready var stamina_bar: ProgressBar = get_parent().get_parent().get_parent().get_parent().get_node('HUD/CanvasLayer/StaminaBar')

const SPEED = 2.5
const SPRINT_MULTIPLIER = 2.0
const JUMP_VELOCITY = 4.5
const CLIMB_SPEED = 2.0

const MAX_STAMINA = 100.0
const STAMINA_DRAIN_SPRINT = 10.0
const STAMINA_DRAIN_CLIMB = 8.0
const STAMINA_RECOVERY = 5.0

var stamina: float = MAX_STAMINA
var paused: bool = true

@onready var climb_ray: RayCast3D = get_node_or_null("ClimbRay")

func _ready() -> void:
	if climb_ray == null:
		# Try sibling path if you placed it next to the character
		climb_ray = get_node_or_null("../ClimbRay")
	if climb_ray == null:
		push_warning("ClimbRay not found. Add a RayCast3D named 'ClimbRay' under CharacterBody3D.")
		return

	# Set defaults only after confirming the node exists
	climb_ray.enabled = true
	climb_ray.target_position = Vector3(0, 0, 1.5)  # local forward (-Z) by 1.5m

func _physics_process(delta: float) -> void:
	if paused:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Camera-relative input
	var input_dir := Input.get_vector("arrow_left", "arrow_right", "arrow_down", "arrow_up")
	var cam_basis = cam.global_transform.basis
	var forward = -cam_basis.z.normalized()
	var right = cam_basis.x.normalized()
	var direction = (forward * input_dir.y + right * input_dir.x).normalized()

	# Update climb ray to point in direction of travel
	if direction != Vector3.ZERO:
		climb_ray.target_position = direction * 1.5   # 1.5m ahead
		climb_ray.force_raycast_update()

	# Sprinting
	var current_speed = SPEED
	if Input.is_action_pressed("shift") and stamina > 0:
		current_speed *= SPRINT_MULTIPLIER
		stamina = max(stamina - STAMINA_DRAIN_SPRINT * delta, 0)

	# Movement
	if direction != Vector3.ZERO:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Jump vs continuous climb on Space:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("ui_accept") and input_dir.y > 0 and climb_ray.is_colliding() and stamina > 0:
		# Continuous climb while Space is held and blocked forward
		velocity.y = CLIMB_SPEED
		stamina = max(stamina - STAMINA_DRAIN_CLIMB * delta, 0)

	move_and_slide()

	# Recover stamina when not sprinting or climbing
	var climbing_now = Input.is_action_pressed("ui_accept") and input_dir.y > 0 and climb_ray.is_colliding()
	if not Input.is_action_pressed("shift") and not climbing_now:
		stamina = min(stamina + STAMINA_RECOVERY * delta, MAX_STAMINA)
	
	stamina_bar.value = stamina

func _on_main_paused():
	paused = true

func _on_main_resumed():
	paused = false
