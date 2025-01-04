extends Control

var score : int = 0
var score_timer : int = 0
var up_score_timer : int = 1
var up_score : int = 1
var final_score : int = 0
var max_score : int = 0
var level : int = 0

var score_save : ScoreRs

@export var basicScoreLabel : Label
@export var timeLabel : Label
@export var currentScoreLabel : Label
@export var maxScoreLabel : Label
@export var levelLabel : Label

func _ready() -> void:
	score_save = ScoreRs.load_or_create()
	max_score = score_save.max_score
	maxScoreLabel.text = "Max Score: %s" % max_score
	
func _on_mob_squashed():
	score += up_score
	calculate_final_score()
	basicScoreLabel.text = "Score: %s" % score

func _on_score_timer_timeout() -> void:
	score_timer += 1
	calculate_final_score()
	timeLabel.text = "Time: %s" %score_timer
	
func save_score():
	
	if final_score > score_save.max_score:
		score_save.max_score = final_score
		score_save.save()
		
func calculate_final_score() -> void:
	final_score = score * 2 + score_timer 
	currentScoreLabel.text = "Current Score: %s" %final_score
	
func _on_player_hit() -> void:
	save_score()


func _on_mob_speed_timer_timeout() -> void:
	level += 1
	levelLabel.text = "Level: %s" %level
