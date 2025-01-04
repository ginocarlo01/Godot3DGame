extends Node

@export var mob_scene: PackedScene

@export var mobTimer : Timer
@export var scoreTimer : Timer
@export var mobSpeedTimer : Timer

@export var speedMobModifierPerTimer : float

var finalSpeedMaxMobModifier : float = 1

@export var inGameUI : Control

@export var pause_menu : Control
var pause := false

func _ready():
	inGameUI.hide()
	if UiManager.started == false:
		$UI/StartScreen.show()
		
	else:
		start_game()
		
	$UI/Retry.hide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	pause = !pause
	if pause:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	

func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = $SpawnPath/SpawnLocation
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position, finalSpeedMaxMobModifier)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
	mob.squashed.connect($UI/InGame._on_mob_squashed.bind())
	mob.squashed.connect($SFX._on_mob_squashed.bind())


func _on_player_hit() -> void:
	mobTimer.stop()
	scoreTimer.stop()
	mobSpeedTimer.stop()
	$UI/Retry.show()
	$UI/InGame.hide()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UI/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()


func _on_button_pressed() -> void:
	start_game()
	UiManager.started = true
	
	
func start_game() -> void:
	inGameUI.show()
	mobTimer.start()
	scoreTimer.start()
	mobSpeedTimer.start()
	$Player.show()
	
	$UI/StartScreen.hide()
	


func _on_mob_speed_timer_timeout() -> void:
	finalSpeedMaxMobModifier+=speedMobModifierPerTimer
