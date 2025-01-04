extends Label

var score_timer := 0

func _on_score_timer_timeout() -> void:
	score_timer += 1
	text = "Time: %s" %score_timer
	
