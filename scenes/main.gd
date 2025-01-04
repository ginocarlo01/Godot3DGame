extends Node

@export var mob_scene: PackedScene

func _ready():
	if UiManager.started == false:
		$UI/StartScreen.show()
	else:
		start_game()
		
	$UI/Retry.hide()

func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = $SpawnPath/SpawnLocation
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
	mob.squashed.connect($UI/ScoreLabel._on_mob_squashed.bind())


func _on_player_hit() -> void:
	$MobTimer.stop()
	$UI/Retry.show()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UI/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()


func _on_button_pressed() -> void:
	start_game()
	UiManager.started = true
	
	
func start_game() -> void:
	$MobTimer.start()
	$Player.show()
	$UI/StartScreen.hide()
