extends CharacterBody2D

var start_position : Vector2

func _ready() -> void:
	start_position = global_position

func reset():
	global_position = start_position

func on_wind_element(dir : float):
	velocity.x = 100 * dir

func _physics_process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		velocity.x = move_toward(velocity.x, 0, 100 * delta)
		
		if not is_on_floor():
			velocity.y += 500 * delta
		else:
			velocity.y = 0
		move_and_slide()
