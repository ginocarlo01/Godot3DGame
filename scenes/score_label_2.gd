extends Label

var score_save : ScoreRs
var score := 0

func _ready() -> void:
	score_save = ScoreRs.load_or_create()
	score = score_save.max_score
	text = "Max Score: %s" % score
