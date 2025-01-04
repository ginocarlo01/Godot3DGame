extends Node

@export var hitEnemySFX : AudioStreamPlayer2D
@export var deathSFX : AudioStreamPlayer2D
@export var jumpSFX : AudioStreamPlayer2D
@export var startSFX : AudioStreamPlayer2D


func _on_button_pressed() -> void:
	startSFX.play()

func _on_player_jump_signal() -> void:
	jumpSFX.play()
	
func _on_mob_squashed():
	hitEnemySFX.play()
	
func _on_player_hit() -> void:
	deathSFX.play()
