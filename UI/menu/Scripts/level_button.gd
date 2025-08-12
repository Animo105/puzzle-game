extends Button
class_name LevelButton

const FONT = preload("res://UI/Fonts/PixelOperatorMonoHB.ttf")

var level_id : int

func _init(id : int) -> void:
	level_id = id

func _ready() -> void:
	set("theme_override_fonts/font", FONT)
	set("theme_override_font_sizes/font_size", 10)
	pressed.connect(_on_pressed)
	text = LevelManager.levels[level_id]["level_name"]

func _on_pressed():
	Global.current_level = level_id
	Global.game_manager.change_with_fade(LevelManager.levels[level_id]["level_scene"])
