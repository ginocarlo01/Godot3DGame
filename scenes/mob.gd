extends CharacterBody3D

signal squashed

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18

@export var min_degrees = -45

@export var max_degrees = 45



func _physics_process(_delta):
	move_and_slide()

# This function will be called from the Main scene.
func initialize(start_position, player_position, max_speed_modifier):
	# We position the mob by placing it at start_position
	# and rotate it towards player_position, so it looks at the player.
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotate this mob randomly within range of -45 and +45 degrees,
	# so that it doesn't move directly towards the player.
	rotate_y(randf_range(degree_to_radians(min_degrees), degree_to_radians(max_degrees)))
	# We calculate a random speed (integer)
	print(max_speed_modifier)
	var random_speed = randi_range(min_speed, max_speed * max_speed_modifier)
	# We calculate a forward velocity that represents the speed.
	velocity = Vector3.FORWARD * random_speed
	# We then rotate the velocity vector based on the mob's Y rotation
	# in order to move in the direction the mob is looking.
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	$AnimationPlayer.speed_scale = random_speed / min_speed


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
	
func squash():
	squashed.emit()
	queue_free()

func degree_to_radians(value) -> int:
	
	return (value * PI / 180)
