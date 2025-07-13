extends CanvasLayer

signal faded_in
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	visible = false

func fade_in():
	visible = true
	animation_player.play("fade_in")

func fade_out():
	animation_player.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		faded_in.emit()
	elif anim_name == "fade_out":
		visible = false
