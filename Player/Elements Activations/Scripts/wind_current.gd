extends Area2D

var exception_list : Array[Node2D] = []

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	$AnimationPlayer.animation_finished.connect(_animation_finished)
	$AnimationPlayer.play("blow")

func _on_body_entered(body : Node2D)->void:
	if exception_list.has(body): return
	if body.has_method("on_wind_element"):
		exception_list.append(body)
		body.on_wind_element(scale.x)

func _animation_finished(anim_name : String):
	queue_free()

func reset():
	queue_free()
