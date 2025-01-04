extends Label

var score : int = 0
var score_timer : int = 0
var score_save : ScoreRs
var up_score_timer : int = 1
var up_score : int = 1
var final_score : int = 0

func _ready() -> void:
	score_save = ScoreRs.load_or_create()

func _on_mob_squashed():
	score += up_score
	text = "Score: %s" % score

func save_score():
	_final_score()
	if final_score > score_save.max_score:
		score_save.max_score = final_score
		score_save.save()

func _on_player_hit() -> void:
	save_score()

func _on_score_timer_timeout() -> void:
	score_timer += up_score_timer
	
func _final_score() -> int:
	final_score = score * 2 + score_timer / 2
	return final_score
