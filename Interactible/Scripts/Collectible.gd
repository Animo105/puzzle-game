extends Area2D
class_name Collectible

func _init():
	body_entered.connect(_on_player_enter)
	collision_layer = 0
	collision_mask = 2

func _on_player_enter(body: Node2D)->void:
	if body is Player:
		collect()

func collect():
	pass
