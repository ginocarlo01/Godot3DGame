class_name ScoreRs
extends Resource

@export var max_score : int = 0

func save():
	ResourceSaver.save(self, "res://saveMyScore.tres")
	
static func load_or_create() -> ScoreRs:
	var resource: ScoreRs = load("res://saveMyScore.tres") as ScoreRs
	if !resource:
		resource = ScoreRs.new()
	return resource
