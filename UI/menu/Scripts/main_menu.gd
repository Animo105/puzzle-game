extends Control

func _on_start_pressed() -> void:
	Global.game_manager.change_scene("res://UI/menu/levels.tscn")

func _on_options_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
