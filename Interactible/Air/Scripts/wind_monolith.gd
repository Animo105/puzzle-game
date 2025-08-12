extends Collectible

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func collect():
	Global.wind_element = 5
