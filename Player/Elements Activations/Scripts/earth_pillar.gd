extends StaticBody2D

func _ready() -> void:
	$AnimationPlayer.play("rise")

func reset():
	queue_free()
