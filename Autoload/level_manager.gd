extends Node

const LEVELLHEADER_PATH :String = "res://Levels/level_header.json"
var levels : Array = []

func _ready() -> void:
	var file := FileAccess.open(LEVELLHEADER_PATH, FileAccess.READ)
	var data : Array = []
	if file:
		var text = file.get_as_text()
		levels = JSON.parse_string(text)
		file.close()
