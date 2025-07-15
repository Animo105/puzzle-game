extends Collectible
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	reset()

func collect():
	Global.water_element += 1
	visible = false
	call_deferred("set_collision", false)
	animated_sprite_2d.stop()
	

func reset():
	animated_sprite_2d.play("default")
	visible = true
	call_deferred("set_collision", true)

func set_collision(state : bool):
	collision_shape_2d.disabled = !state
