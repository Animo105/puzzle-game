extends Node2D

@export var next_level : int = -1
@export var locked : bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if not locked:
			# next level
			if next_level == -1:
				return
			
			Global.current_level = next_level
			Global.game_manager.change_with_fade(LevelManager.levels[next_level]["level_scene"])
