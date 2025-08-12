extends Collectible

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func collect():
	Global.earth_element = 5
