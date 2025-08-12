extends Control

@onready var button_container: VBoxContainer = $CenterContainer/ScrollContainer/VBoxContainer

func _ready() -> void:
	for level in LevelManager.levels:
		var button := LevelButton.new(level.level_id)
		button_container.add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
