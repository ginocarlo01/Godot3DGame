extends Label

var score : int = 0
var score_save : ScoreRs

func _ready() -> void:
	score_save = ScoreRs.load_or_create()

func _on_mob_squashed():
	score += 1
	text = "Score: %s" % score

func save_score():
	if score > score_save.max_score:
		score_save.max_score = score
		score_save.save()
	

func _on_player_hit() -> void:
	save_score()
